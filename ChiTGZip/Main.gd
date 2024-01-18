#MIT License
#
#Copyright (c) 2023 Chimbal
#
#Permission is hereby granted, free of charge, to any person obtaining a copy
#of this software and associated documentation files (the "Software"), to deal
#in the Software without restriction, including without limitation the rights
#to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#copies of the Software, and to permit persons to whom the Software is
#furnished to do so, subject to the following conditions:
#
#The above copyright notice and this permission notice shall be included in all
#copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#SOFTWARE.

extends Node2D

const root = "/root/Main";
const base = root+"/base";
const main_menu = root+"/main_menu";
const Szip = root+"/Szip";
const tar = root+"/tar";
const gzip = root+"/gzip";
const settings = root+"/settings";
const about = root+"/about";
const dialog = root+"/dialog";

var chitgzip : String = "ChiTGZip v1.0";
var selectedFile : String = "";
var outputPath : String = "";
var fileName : String = "";
var chi_exe_dir : String = OS.get_executable_path().get_base_dir();

var exit_codes_linux = {
	0:"All right.",
	1:"General error",
	2:"Misuse of shell builtins",
	126:"Command invoked cannot execute",
	127:"Command not found",
	128:"Invalid argument to exit",
	130:"Script terminated by Control-C"
}

var nodes : Array = [base, main_menu, Szip, tar, gzip, settings, about];
var base_btn_small : Array = [base+"/BTN_input", base+"/BTN_output"];
var base_labels : Array = [base+"/Input_path", base+"/Output_path"];
var base_bg : Array = [base+"/BG_input", base+"/BG_right", base+"/BG_output", root+"/ColorRect"];

var main_menu_btn : Array = [main_menu+"/BTN_Szip", main_menu+"/BTN_tar", main_menu+"/BTN_gzip", main_menu+"/BTN_settings", main_menu+"/BTN_about"];
var main_menu_labels_small : Array = [main_menu+"/version"];
var main_menu_bg : Array = [main_menu+"/BG"];

var Szip_nodes : Array = [Szip+"/add", Szip+"/open", Szip+"/other"];
var Szip_btn_small : Array = [Szip+"/BTN_add", Szip+"/BTN_open", Szip+"/BTN_other", Szip+"/add/BTN_archive"];
var Szip_labels : Array = [Szip+"/caption"];
var Szip_bg : Array = [Szip+"/add/BG", Szip+"/open/BG", Szip+"/other/BG"];

var settings_btn : Array = [settings+"/Button3", settings+"/Button4", settings+"/Button5", settings+"/Button6"];
var settings_bg : Array = [settings+"/BG"];

var about_text : Array = [about+"/TextEdit"];
var about_bg : Array = [about+"/BG"];

var dialog_bg : Array = [dialog+"/BG"];

var file_dialog : Array = [root+"/FileDialogSelect", root+"/PathDialogSelect"];

var all_nodes : Array = [];
var text_nodes : Array = [];
var text_nodes_small : Array = [];

func _ready():
	all_nodes += nodes+base_btn_small+base_labels+base_bg;
	all_nodes += main_menu_btn+main_menu_labels_small+main_menu_bg;
	all_nodes += Szip_nodes+Szip_btn_small+Szip_labels+Szip_bg;
	all_nodes += settings_bg+settings_btn;
	all_nodes += about_text+about_bg;
	all_nodes += dialog_bg+file_dialog;
	text_nodes += Szip_labels+about_text;
	text_nodes_small += main_menu_labels_small+base_labels;
	
	on_ready();

func on_ready():
	for item in nodes:
		get_node(item).on_ready();

func _on_Input_path_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed and selectedFile == "":
		$FileDialogSelect.popup();

func _on_BTN_input_pressed():
	$FileDialogSelect.popup();
	
func _on_BTN_output_pressed():
	$PathDialogSelect.popup();

func _on_FileDialogSelect_dir_selected(dir):
	chi_input_selected(dir);

func _on_FileDialogSelect_file_selected(path):
	chi_input_selected(path);

func _on_PathDialogSelect_dir_selected(dir):
	chi_output_selected(dir);

func chi_dialogs_clear():
	for item in file_dialog:
		get_node(item).current_dir = "";
		get_node(item).current_file = "";
		get_node(item).current_path = "";

func chi_input_selected(path:String):
	selectedFile = path;
	outputPath = $FileDialogSelect.current_dir;
	fileName = $FileDialogSelect.current_file;
	$base/Input_path.text = selectedFile;
	$base/Output_path.text = outputPath;
	chi_dialogs_clear();

func chi_output_selected(dir:String):
	outputPath = dir;
	$base/Output_path.text = outputPath;
	chi_dialogs_clear();

func chi_execute_command(cname:String, command:String, args:Array = [], chmod:bool = true, block:bool = true, stderr:bool = false, open_console:bool = false):
	# Example use (Linux):
	# chi_execute_command("CPU Info", "lscpu");
	# chi_execute_command("NeoFetch", "bash", ["/Tools_Linux/neofetch710/neofetch", "--stdout", "--color_blocks off"], true);
	var cmd_output = [""];
	var chmod_output = [""];
	# chi_execute_command("NeoFetch", "bash", [chi_exe_dir+"/Tools_Linux/neofetch710/neofetch", "--stdout", "--color_blocks off"], true);
	# chi_execute_command("DMI Decode v3.5", "pkexec", [chi_exe_dir+"/Tools_Linux/dmi_decode_35/dmidecode.exec"], true);
	var exit_code_str = "";
	var exit_code;
	var exit_code_ch;

	if chmod == true:
		exit_code_ch = OS.execute("chmod", ["u+x", args[0]], block, chmod_output, stderr, open_console);
	exit_code = OS.execute(command, args, block, cmd_output, stderr, open_console);
	if cmd_output[0] != "":
		pass;
		#get_node(root).chi_show_message(str("Command: ", command, "\nArguments: ", args, "\n", spacer, "\n", cmd_output[0], "\n\n"), cname);
	else:
		if exit_codes_linux[exit_code] != null: exit_code_str = " - ( "+exit_codes_linux[exit_code]+" )";
		else: exit_code_str = " - ( Undefined error code )";
		#get_node(root).chi_show_message(str("Command: ", command, "\nArguments: ", args, "\nError code: ", exit_code, exit_code_str, "\n\n"), cname);
	var chmod_output1 = [""];

