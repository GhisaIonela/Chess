extends Node
class_name MoveManagerOld
@onready var chess_move_area = preload("res://controllers/chess_move_area.tscn")
#@onready var tilemap = $TileMap

const chessPiece = preload("res://chess_pieces/chess_piece.tscn")
@onready var pieces = $Pieces
#var piece_positions = []
#func setupPiecePositions():
#	for piece in pieces.get_children():
#		piece_positions.append([piece.position, piece.type, piece.color])
func setupPieces(color: ChessPiece.COLOR):
	for column in range(0,8):
		var row_range
		match color:
			ChessPiece.COLOR.BLACK:
				row_range = [0,1]
			ChessPiece.COLOR.WHITE:
				row_range = [6,7]
		for row in row_range:
			var piece = chessPiece.instantiate()
			pieces.add_child(piece)
			piece.color = color
#			piece.position = Vector2((32*(2*column+1)),42*(row+1)+(row*21))
			piece.position += Vector2(64*(column+1),64*(row+1))
			match [column, row]:
				[0,0], [7,0], [0,7], [7,7]:
					piece.type = ChessPiece.TYPE.ROOK
				[1,0], [6,0], [1,7], [6,7]:
					piece.type = ChessPiece.TYPE.KNIGHT
				[2,0], [5,0], [2,7], [5,7]:
					piece.type = ChessPiece.TYPE.BISHOP
				[3,0], [3,7]:
					piece.type = ChessPiece.TYPE.QUEEN
				[4,0], [4,7]:
					piece.type = ChessPiece.TYPE.KING

func _ready():
#	setupPiecePositions()
	setupPieces(ChessPiece.COLOR.BLACK)
	setupPieces(ChessPiece.COLOR.WHITE)
#	var scene = get_tree().current_scene
#	for i in range(8):
#		for j in range(8):
#			var area = chess_move_area.instantiate()
#			area.set("position", Vector2(i*64, j*64))
#			scene.add_child.call_deferred(area)

