extends Test
##


##
func _ready() -> void : 
	for recipe : SwordRecipe in SwordRecipe.recipes : 
		print_info("Testing recipe Tier %s Level %s" %[recipe.tier, recipe.level])
		var sword : Sword = Sword.create_sword(recipe)
		_check_sword(sword, recipe)
		print_info("===============")
	
	tests_completed.emit()
	queue_free()


##
func _check_sword(sword : Sword, recipe : SwordRecipe) -> void : 
	if sword.level == recipe.level : 
		print_check("Sword level matches recipe.")
	else : 
		print_fail("Sword level doesn't match recipe.")
	
	if sword.tier == recipe.tier : 
		print_check("Sword tier matches recipe.")
	else : 
		print_fail("Sword tier doesn't match recipe.")
	
	if sword.forge_rate >= 1 and sword.forge_rate <= 1000 : 
		print_check("Sword forge rate seems correct.")
	else :
		print_fail("Sword forge rate is out of bound.")
	
	if SwordPart.sword_parts.has(sword.get_blade_part().key) :
		print_check("Blade part exists.")
	else : 
		print_fail("Blade part doesn't exists.")
	
	if sword.get_blade_part().type == SwordPart.Type.BLADE : 
		print_check("Blade part is blade type.")
	else : 
		print_fail("Blade part is not blade type.")
	
	if sword.get_blade_part().tier == sword.tier and sword.get_blade_part().tier > 0 : 
		print_check("Blade part tier matches sword.")
	else : 
		print_fail("Blade part tier doesn't match sword.")
	
	if sword.get_blade_part().level <= sword.level and sword.get_blade_part().level > 0 : 
		print_check("Blade part level matches sword.")
	else : 
		print_fail("Blade part level doesn't match sword.")
	
	if SwordPart.sword_parts.has(sword.get_handle_part().key) :
		print_check("Handle part exists.")
	else : 
		print_check("Handle part doesn't exists.")
	
	if sword.get_handle_part().type == SwordPart.Type.HANDLE : 
		print_check("Handle part is handle type.")
	else : 
		print_fail("Handle part is not handle type.")
	
	if sword.get_handle_part().tier == sword.tier and sword.get_handle_part().tier > 0 : 
		print_check("Handle part tier matches sword.")
	else : 
		print_fail("Handle part tier doesn't match sword.")
	
	if sword.get_handle_part().level <= sword.level and sword.get_handle_part().level > 0 : 
		print_check("Handle part level matches sword.")
	else : 
		print_fail("Handle part level doesn't match sword.")
	
	if sword.get_guard_part().type == SwordPart.Type.GUARD : 
		print_check("Guard part is guard type.")
	else : 
		print_fail("Guard part is not guard type.")
	
	if sword.get_guard_part().tier == sword.tier and sword.get_guard_part().tier > 0 : 
		print_check("Guard part tier matches sword.")
	else : 
		print_fail("Guard part tier doesn't match sword.")
	
	if sword.get_guard_part().level <= sword.level and sword.get_guard_part().level > 0 : 
		print_check("Guard part level matches sword.")
	else : 
		print_fail("Guard part level doesn't match sword.")
	
	if sword.get_pommel_part().type == SwordPart.Type.POMMEL : 
		print_check("Pommel part is pommel type.")
	else : 
		print_fail("Pommel part is not pommel type.")
	
	if sword.get_pommel_part().tier == sword.tier and sword.get_pommel_part().tier > 0 : 
		print_check("Pommel part tier matches sword.")
	else : 
		print_fail("Pommel part tier doesn't match sword.")
	
	if sword.get_pommel_part().level <= sword.level and sword.get_pommel_part().level > 0 : 
		print_check("Pommel part level matches sword.")
	else : 
		print_fail("Pommel part level doesn't match sword.")
