tool  # this makes the script run in the editor

extends StaticBody2D

# dictionary of items types
enum Items {barrelBlack_side, barrelBlack_top, barrelGreen_side,
            barrelGreen_top, barrelRed_side, barrelRed_top,
            barrelRust_side, barrelRust_top, barricadeMetal,
            barricadeWood, fenceRed, fenceYellow, sandbagBeige,
            sandbagBeige_open, sandbagBrown, sandbagBrown_open,
            treeBrown_large, treeBrown_small, treeGreen_large,
            treeGreen_small}

# dictionary of regions
var regions = {
    Items.barrelBlack_side: Rect2(532, 90, 56, 40),
    Items.barrelBlack_top: Rect2(220, 89, 48, 48),
    Items.barrelGreen_side: Rect2(476, 90, 56, 40),
    Items.barrelGreen_top: Rect2(220, 137, 48, 48),
    Items.barrelRed_side: Rect2(420, 94, 56, 40),
    Items.barrelRed_top: Rect2(172, 89, 48, 48),
    Items.barrelRust_side: Rect2(588, 90, 56, 40),
    Items.barrelRust_top: Rect2(172, 137, 48, 48),
    Items.barricadeMetal: Rect2(532, 130, 56, 56),
    Items.barricadeWood: Rect2(72, 130, 56, 56),
    Items.fenceRed: Rect2(336, 443, 32, 96),
    Items.fenceYellow: Rect2(216, 550, 32, 104),
    Items.sandbagBeige: Rect2(164, 282, 44, 64),
    Items.sandbagBeige_open: Rect2(518, 350, 55, 84),
    Items.sandbagBrown: Rect2(622, 278, 44, 64),
    Items.sandbagBrown_open: Rect2(596, 450, 55, 84),
    Items.treeBrown_large: Rect2(0, 654, 128, 128),
    Items.treeBrown_small: Rect2(694, 118, 72, 72),
    Items.treeGreen_large: Rect2(128, 654, 128, 128),
    Items.treeGreen_small: Rect2(694, 190, 72, 72)
}

# We want to be able to choose the item from the Inspector, 
# so we need to export a variable that uses the Items enum:
export (Items) var type setget _update

# Setting the type variable will trigger the _update() function, 
# which sets the Region and creates a correctly sized collision rectangle:
func _update(_type = Items.barrelBlack_side):
	type = _type
	if !Engine.editor_hint: # if not in editor mode, meaning, if the obstacle _update is called in the game
		yield(self, 'tree_entered') # wait for the node to be initialized first before looking for sprite
	$Sprite.region_rect = regions[type]
	var rect = RectangleShape2D.new()  # create new region rect
	rect.extents = $Sprite.region_rect.size / 2
	$CollisionShape2D.shape = rect
	