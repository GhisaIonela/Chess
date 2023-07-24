extends Node2D
class_name MoveManager
@onready var chess_move_area = preload("res://controllers/chess_move_area.tscn")

const chessPiece = preload("res://chess_pieces/chess_piece.tscn")
@onready var pieces = $Pieces
const available_position = preload("res://controllers/available_position.tscn")
@onready var available_moves = $Available_Moves

var positions = {}
var current_move : Vector2
var BOUNDS = {"left": global_position.x+64, "right": global_position.x+64*8, 
				"up": global_position.y+64, "down": global_position.y+64*8}
var SELECTED_PIECE : ChessPiece

func setupPieces(color: ChessPiece.COLOR):
	for column in range(0,8):
		var row_range
		match color:
			ChessPiece.COLOR.BLACK:
				row_range = [0,1]
			ChessPiece.COLOR.WHITE:
				row_range = [6,7]
		for row in row_range:
			var new_piece = chessPiece.instantiate()
			pieces.add_child(new_piece)
			new_piece.color = color
			new_piece.position = Vector2(64*(column+1),64*(row+1))
			new_piece.piece_selected.connect(_on_piece_selected)
			new_piece.BOUNDS = self.BOUNDS
			positions[new_piece] = new_piece.position
			match [column, row]:
				[0,0], [7,0], [0,7], [7,7]:
					new_piece.type = ChessPiece.TYPE.ROOK
				[1,0], [6,0], [1,7], [6,7]:
					new_piece.type = ChessPiece.TYPE.KNIGHT
				[2,0], [5,0], [2,7], [5,7]:
					new_piece.type = ChessPiece.TYPE.BISHOP
				[3,0], [3,7]:
					new_piece.type = ChessPiece.TYPE.QUEEN
				[4,0], [4,7]:
					new_piece.type = ChessPiece.TYPE.KING

func _ready():
	setupPieces(ChessPiece.COLOR.BLACK)
	setupPieces(ChessPiece.COLOR.WHITE)

func _on_piece_selected(piece):
	SELECTED_PIECE = piece
	handle_selected_piece_available_positions(piece)

func handle_selected_piece_available_positions(piece):
	for available_move in available_moves.get_children():
		available_move.queue_free()
	match piece.type:
		ChessPiece.TYPE.PAWN:
			pawn_move(piece)
		ChessPiece.TYPE.BISHOP:
			bishop_move(piece)
		ChessPiece.TYPE.KNIGHT:
			knight_move(piece)
		ChessPiece.TYPE.ROOK:
			rook_move(piece)
		ChessPiece.TYPE.QUEEN:
			bishop_move(piece)
			rook_move(piece)
		ChessPiece.TYPE.KING:
			king_move(piece)

func _on_select_available_position(pos):
	positions[SELECTED_PIECE] = pos
	SELECTED_PIECE.position = pos
	for available_move in available_moves.get_children():
		available_move.queue_free()

func setup_available_position(available_position: AvailablePosition, coordinates: Vector2, color: ChessPiece.COLOR):
	available_position.position = coordinates
	available_position.color = color
	available_position.move_selected.connect(_on_select_available_position)
	return available_position

func pawn_move(pawn):
	match pawn.color:
		ChessPiece.COLOR.WHITE:
			if pawn.position.y > 64 and positions.find_key(pawn.position + Vector2(0,-64))==null:
				available_moves.add_child(setup_available_position(available_position.instantiate(), 
																	pawn.position + Vector2(0,-64), 
																	pawn.color))
			if pawn.position.y == 64*7:
				if pawn.position.y-64 > 64 and positions.find_key(pawn.position + Vector2(0,-2*64))==null and positions.find_key(pawn.position + Vector2(0,-64))==null:
					available_moves.add_child(setup_available_position(available_position.instantiate(), 
																		pawn.position + Vector2(0,-2*64), 
																		pawn.color))
		ChessPiece.COLOR.BLACK:
			if pawn.position.y < 64*8 and positions.find_key(pawn.position + Vector2(0,64))==null:
				available_moves.add_child(setup_available_position(available_position.instantiate(), 
										pawn.position + Vector2(0,64), 
										pawn.color))
			if pawn.position.y == 64*2 and positions.find_key(pawn.position + Vector2(0,2*64))==null and positions.find_key(pawn.position + Vector2(0,64))==null:
				if pawn.position.y+64 < 64*8:
					available_moves.add_child(setup_available_position(available_position.instantiate(), 
											pawn.position + Vector2(0,2*64), 
											pawn.color))
			
func bishop_move(bishop):
	var i = bishop.position.x
	var j = bishop.position.y
	while(i > 64 and j > 64 and positions.find_key(Vector2(i-64,j-64))==null):
		available_moves.add_child(setup_available_position(available_position.instantiate(), 
															Vector2(i-64,j-64), 
															bishop.color))
		i -= 64
		j -= 64
	i = bishop.position.x
	j = bishop.position.y
	while(i < 64*8 and j < 64*8 and positions.find_key(Vector2(i+64,j+64))==null):
		available_moves.add_child(setup_available_position(available_position.instantiate(), 
															Vector2(i+64,j+64), 
															bishop.color))
		i += 64
		j += 64
	i = bishop.position.x
	j = bishop.position.y
	while(i > 64 and j < 64*8 and positions.find_key(Vector2(i-64,j+64))==null):
		available_moves.add_child(setup_available_position(available_position.instantiate(), 
															Vector2(i-64,j+64), 
															bishop.color))
		i -= 64
		j += 64
	i = bishop.position.x
	j = bishop.position.y
	while(i < 64*8 and j > 64 and positions.find_key(Vector2(i+64,j-64))==null):
		available_moves.add_child(setup_available_position(available_position.instantiate(), 
															Vector2(i+64,j-64), 
															bishop.color))
		i += 64
		j -= 64

func knight_move(knight):
	var i = knight.position.x
	var j = knight.position.y
	if i + 64*2 <= 64*8 and j + 64 <= 64*8 and positions.find_key(knight.position + Vector2(64*2,64)) == null:
		available_moves.add_child(setup_available_position(available_position.instantiate(), 
													knight.position + Vector2(64*2,64), 
													knight.color))
	if i + 64 <= 64*8 and j + 64*2 <= 64*8 and positions.find_key(knight.position + Vector2(64,64*2)) == null:
		available_moves.add_child(setup_available_position(available_position.instantiate(), 
											knight.position + Vector2(64,64*2), 
											knight.color))
	if i - 64*2 >= 64 and j - 64 >= 64 and positions.find_key(knight.position + Vector2(-64*2,-64)) == null:
		available_moves.add_child(setup_available_position(available_position.instantiate(), 
											knight.position + Vector2(-64*2,-64), 
											knight.color)) 
	if i - 64 >= 64 and j - 64*2 >= 64 and positions.find_key(knight.position + Vector2(-64,-64*2)) == null:
		available_moves.add_child(setup_available_position(available_position.instantiate(), 
											knight.position + Vector2(-64,-64*2), 
											knight.color)) 
	if i + 64 <= 64*8 and j - 64*2 >= 64 and positions.find_key(knight.position + Vector2(64, -64*2)) == null:
		available_moves.add_child(setup_available_position(available_position.instantiate(), 
											knight.position + Vector2(64,-64*2), 
											knight.color)) 
	if i + 64*2 <= 64*8 and j - 64 >= 64 and positions.find_key(knight.position + Vector2(64*2,-64)) == null:
		available_moves.add_child(setup_available_position(available_position.instantiate(), 
											knight.position + Vector2(64*2,-64), 
											knight.color)) 
	if i - 64 >= 64 and j + 64*2 <= 64*8 and positions.find_key(knight.position + Vector2(-64,64*2)) == null:
		available_moves.add_child(setup_available_position(available_position.instantiate(), 
											knight.position + Vector2(-64,64*2), 
											knight.color)) 		
	if i - 64*2 >= 64 and j + 64 <= 64*8 and positions.find_key(knight.position + Vector2(-64*2,64)) == null:	
		available_moves.add_child(setup_available_position(available_position.instantiate(), 
											knight.position + Vector2(-64*2,64), 
											knight.color)) 	

func rook_move(rook):
	var i = rook.position.x
	var j = rook.position.y
	while i > 64 and positions.find_key(Vector2(i-64,j)) == null:
		available_moves.add_child(setup_available_position(available_position.instantiate(), 
															Vector2(i-64,j), 
															rook.color))
		i -= 64
	i = rook.position.x
	while j > 64 and positions.find_key(Vector2(i,j-64)) == null:
		available_moves.add_child(setup_available_position(available_position.instantiate(), 
															Vector2(i,j-64), 
															rook.color))
		j -= 64
	i = rook.position.x
	j = rook.position.y
	while i < 64*8 and positions.find_key(Vector2(i+64,j)) == null:
		available_moves.add_child(setup_available_position(available_position.instantiate(), 
															Vector2(i+64,j), 
															rook.color))
		i += 64
	i = rook.position.x
	while j < 64*8 and positions.find_key(Vector2(i,j+64)) == null:
		available_moves.add_child(setup_available_position(available_position.instantiate(), 
															Vector2(i,j+64), 
															rook.color))
		j += 64

func king_move(king):
	var i = king.position.x
	var j = king.position.y
	if i > 64 and j > 64 and positions.find_key(king.position + Vector2(-64,-64)) == null:
		available_moves.add_child(setup_available_position(available_position.instantiate(), 
										king.position + Vector2(-64,-64), 
										king.color))
	if i > 64 and positions.find_key(king.position + Vector2(-64,0)) == null:
		available_moves.add_child(setup_available_position(available_position.instantiate(), 
										king.position + Vector2(-64,0), 
										king.color))
	if j > 64 and positions.find_key(king.position + Vector2(0,-64)) == null:
		available_moves.add_child(setup_available_position(available_position.instantiate(), 
										king.position + Vector2(0,-64), 
										king.color))
	if i < 64*8 and j < 64*8 and positions.find_key(king.position + Vector2(64,64)) == null:
		available_moves.add_child(setup_available_position(available_position.instantiate(), 
										king.position + Vector2(64,64), 
										king.color))
	if i < 64*8 and positions.find_key(king.position + Vector2(64,0)) == null:
		available_moves.add_child(setup_available_position(available_position.instantiate(), 
										king.position + Vector2(64,0), 
										king.color))
	if j < 64*8 and positions.find_key(king.position + Vector2(0,64)) == null:
		available_moves.add_child(setup_available_position(available_position.instantiate(), 
										king.position + Vector2(0,64), 
										king.color))
	if i > 64 and j < 64*8 and positions.find_key(king.position + Vector2(-64,64)) == null:
		available_moves.add_child(setup_available_position(available_position.instantiate(), 
										king.position + Vector2(-64,64), 
										king.color))
	if i < 64*8 and j > 64 and positions.find_key(king.position + Vector2(64,-64)) == null:
		available_moves.add_child(setup_available_position(available_position.instantiate(), 
										king.position + Vector2(64,-64), 
										king.color))
