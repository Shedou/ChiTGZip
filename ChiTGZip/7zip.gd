extends Control
const root : String = "/root/Main";

var chi_exe_dir : String = OS.get_executable_path().get_base_dir();

var menu_items = {
	"add":root+"/Szip/add",
	"open":root+"/Szip/open",
	"other":root+"/Szip/other"
}
var menu_buttons = {
	"add":root+"/Szip/BTN_add",
	"open":root+"/Szip/BTN_open",
	"other":root+"/Szip/BTN_other",
}

func on_ready():
	$caption.text = "Create archive";
	$add.on_ready();
	$open.on_ready();
	$other.on_ready();

func _on_BTN_add_pressed():
	change_menu("add");
	$caption.text = "Create archive";

func _on_BTN_open_pressed():
	change_menu("open");
	$caption.text = "Extract / Edit archive";

func _on_BTN_other_pressed():
	change_menu("other");
	$caption.text = "Tools, info and other";

func change_menu(show_menu:String):
	for chi_item in menu_items:
		get_node(menu_items[chi_item]).visible = false;
		get_node(menu_buttons[chi_item]).pressed = false;
	get_node(menu_items[show_menu]).visible = true;
	get_node(menu_buttons[show_menu]).pressed = true;

