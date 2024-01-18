extends Control

const root = "/root/Main";
var temp_coeff : float = 1.0;

var font_base : DynamicFont;
var font_small : DynamicFont;
export var font_base_size : int = 18;
export var font_small_size : int = 12;
var font_path_data : String = "res://GUI/fonts/Noto_Sans/NotoSans-Regular.ttf";

func on_ready():
	font_base = chi_font_set(font_path_data);
	font_small = chi_font_set(font_path_data);
	chi_font_set_settings(font_base, font_base_size, 1);
	chi_font_set_settings(font_small, font_small_size, 1);
	chi_font_nodes_update();

func chi_font_set(font_data:String):
	var font : DynamicFont = DynamicFont.new();
	font.font_data = load(font_data);
	return font;

func chi_font_set_settings(font:DynamicFont, size:int = 16, outliine_size:int = 0, outline_color:Color = Color(0.316, 0.316, 0.316)):
	font.size = size;
	font.outline_size = outliine_size;
	font.outline_color = outline_color;
	
func chi_font_nodes_update():
	for item in get_node(root).text_nodes:
		get_node(item).set("custom_fonts/font", font_base);
	for item in get_node(root).text_nodes_small:
		get_node(item).set("custom_fonts/font", font_small);

func chi_resize_multi(coefficient:float, elements:Array):
	var window_s_default:Vector2 = Vector2(ProjectSettings.get("display/window/size/width"), ProjectSettings.get("display/window/size/height"));
	var window_s:Vector2;
	var screen_s:Vector2 = OS.get_screen_size();
	if window_s_default * coefficient < screen_s:
		window_s = window_s_default * coefficient;
		OS.window_size = window_s;
		OS.window_position = screen_s / 2 - window_s / 2;
		for item in elements:
			get_node(item).rect_size /= temp_coeff;
			get_node(item).rect_position /= temp_coeff;
		for item in elements:
			get_node(item).rect_size *= coefficient;
			get_node(item).rect_position *= coefficient;
		temp_coeff = coefficient;
		chi_font_set_settings(font_base, int(round(font_base_size * coefficient)), 1);
		chi_font_set_settings(font_small, int(round(font_small_size * coefficient)), 1);
		chi_font_nodes_update();
		
		#var material : ShaderMaterial = get_node("..").get_node("ColorRect").get_active_material(0);
		#material.set_shader_param("shader_param/resolution", OS.get_window_safe_area());
		#get_node("..").get_node("ColorRect").set_shader_param("shader_param/resolution", OS.get_window_safe_area())
		#("shader_param/resolution", OS.get_window_safe_area());

func _on_Button3_pressed():
	chi_resize_multi(1, get_node(root).all_nodes);
	
func _on_Button4_pressed():
	chi_resize_multi(1.25, get_node(root).all_nodes);

func _on_Button5_pressed():
	chi_resize_multi(1.5, get_node(root).all_nodes);

func _on_Button6_pressed():
	chi_resize_multi(2, get_node(root).all_nodes);
