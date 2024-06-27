
func read_csv_data():
	# Reads the data
	var file = FileAccess.open("res://TQ/Assets/Items/ItemSheetA.csv",FileAccess.READ)
	var main_data = {}
	var formated_data = {}
	while !file.eof_reached():
		var data_set = Array(file.get_csv_line())
		main_data[main_data.size()] = data_set
	file.close()
	
	# Formats the data into objects
	main_data.erase(main_data.size()-1)
	var headers = main_data[0]
	for row_index in main_data:
		var base_obj = {}
		var colom_index = 0
		if row_index!=0:
			for data_index in main_data[row_index]:
				base_obj.size()
				base_obj.merge({headers[colom_index]:data_index})
				colom_index+=1
				# Chanage ITEM_NAME to what ever the name for 
			var _key = base_obj["ITEM_NAME"]
			formated_data.merge({_key:base_obj})
	
	return formated_data
