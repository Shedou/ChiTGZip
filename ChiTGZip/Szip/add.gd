extends Control
const root : String = "/root/Main";

var chi_exe_dir : String;
var exec_dir : String;
var ext:String = ".7z";

var res;
var array = [""];
var PID = 0;
var temp;
var temp1;

var thread_1:Thread = Thread.new();
var thread_1_state:bool = false;
var thread_2:Thread = Thread.new();
var thread_2_state:bool = false;


func on_ready():
	chi_exe_dir = get_node(root).chi_exe_dir;
	exec_dir = chi_exe_dir + "/Utils/7z_2301/x64/";

func _on_BTN_archive_pressed():
	#get_node(root).chi_execute_command("test", chi_exe_dir + "/Utils/7z_2301/x64/7zzs.exec", ["a", get_node(root).selectedFile + "_arc" + ext, get_node(root).selectedFile], true, true, false, false);
	#var res = OS.execute(chi_exe_dir + "/Utils/7z_2301/x64/7zzs.exec", ["a", get_node(root).selectedFile + "_arc" + ext, get_node(root).selectedFile], false, array, false, true);
#	if thread_1_state == false:
#		thread_1.start(self, "_thread_1", ["bggg",["args","args"]]);
#	#res = OS.execute("xfce4-terminal", ["a", get_node(root).selectedFile + "_arc" + ext, get_node(root).selectedFile], true, array, false, false);
#	if thread_2_state == false:
#		thread_2.start(self, "_on_timeout", "bggg");

	#int execute(path: String, arguments: PoolStringArray, blocking: bool = true, output: Array = [  ], read_stderr: bool = false, open_console: bool = false)
	res = OS.execute("terminal", ["-e", "/home/chi/GODOT/ChiTGZip/test_script.sh "+exec_dir+" a "+ get_node(root).selectedFile+"_arc"+ext+" "+ get_node(root).selectedFile], false, array, false, false);
	get_node(root + "/Label").text = str(array);


func _on_timeout(cmd):
	temp = thread_1.wait_to_finish();
	get_node(root + "/Label").text = str(array[0]) + str(res) + str(temp);

func _thread_1(command):
	res = OS.execute(exec_dir, ["a", "-bd", get_node(root).selectedFile + "_arc" + ext, get_node(root).selectedFile], true, array);
	#res = OS.execute("exo-open --launch TerminalEmulator", ["a", get_node(root).selectedFile + "_arc" + ext, get_node(root).selectedFile], true, array, false, true);
	#PID = OS.execute("ls", ["-ahl"], true, array);
	get_node(root + "/Label").text = str(array[0]) + "PID:" + str(res);
	return "_thread_1 finished" + " - " + command[0] + " " + str(command[1]);

func _exit_tree():
	thread_1.wait_to_finish();
	thread_2.wait_to_finish();
	pass;
	
	
