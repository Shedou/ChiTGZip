extends Control
const root : String = "/root/Main";

var chi_exe_dir : String;

func on_ready():
	chi_exe_dir = get_node(root).chi_exe_dir;
