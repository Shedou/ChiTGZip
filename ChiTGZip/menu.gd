extends Control
var root = "/root/Main";

var menu_items = {
	"Szip":root+"/Szip",
	"tar":root+"/tar",
	"gzip":root+"/gzip",
	"settings":root+"/settings",
	"about":root+"/about"
}
var menu_buttons = {
	"Szip":root+"/main_menu/BTN_Szip",
	"tar":root+"/main_menu/BTN_tar",
	"gzip":root+"/main_menu/BTN_gzip",
	"settings":root+"/main_menu/BTN_settings",
	"about":root+"/main_menu/BTN_about"
}

func on_ready():
	pass;

func _on_BTN_7zip_pressed():
	change_menu("Szip");

func _on_BTN_tar_pressed():
	change_menu("tar");

func _on_BTN_gzip_pressed():
	change_menu("gzip");

func _on_BTN_settings_pressed():
	change_menu("settings");

func _on_BTN_about_pressed():
	change_menu("about");

func change_menu(show_menu:String):
	for chi_item in menu_items:
		get_node(menu_items[chi_item]).visible = false;
		get_node(menu_buttons[chi_item]).pressed = false;
	get_node(menu_items[show_menu]).visible = true;
	get_node(menu_buttons[show_menu]).pressed = true;
