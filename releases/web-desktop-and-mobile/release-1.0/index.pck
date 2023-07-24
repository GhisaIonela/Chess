GDPC                 �                                                                      %   X   res://.godot/exported/133200997/export-0aaa2c84e4a2f194841ec83e14db9ed9-chess_table.scn )      {      �?7f۵l�8!�T}+ʳ    X   res://.godot/exported/133200997/export-0decd75b32a47a22134ebcf9642c246a-move_manager.scn I      *      ��N!y�LGClm�7;    \   res://.godot/exported/133200997/export-8a4be96665b612e7674338382922fd94-chess_move_area.scn �>      8      ��|�/߿��9���*    P   res://.godot/exported/133200997/export-b25f410ac0d91cdecf41dcbf483f032f-node.scn�.      �      �#K?��������    T   res://.godot/exported/133200997/export-d0f61513d6cd1d62dc97be967a767129-tile_map.scn05      n	      �K���4���(��}    X   res://.godot/exported/133200997/export-ff5329f87f2609f6a6262b03d8c5d3d2-chess_piece.scn �      a      �&@�oso��l�~�    ,   res://.godot/global_script_class_cache.cfg  ��      	      �b�"���F�fNO�MA    L   res://.godot/imported/chess_pieces.png-218667da82b136a50484db49ffe6691d.ctex�      V      ����d���_]�7{    L   res://.godot/imported/chess_table.png-4167b35c68ab2328d903784b8e628f9d.ctex  �      l       ��	`������G��    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex`�      �      �̛�*$q�*�́     X   res://.godot/imported/index.apple-touch-icon.png-aee0db1fcba6b98a735f2f7f22b48105.ctex  `M      d      \+�:���K1��3�    L   res://.godot/imported/index.icon.png-c0bc0b5efb62fc2599b228707fd41b63.ctex  �l      �      �̛�*$q�*�́     H   res://.godot/imported/index.png-00c435162d66b7c774d33d678d20600c.ctex   `z      -      �%�$����<�׿�+    L   res://.godot/imported/move-self.mp3-5dfe84bd17722bc9270c00455c93cc3b.mp3str        �      ۶!5�j�t��
�3�       res://.godot/uid_cache.bin  ��            Ga��gvK�D���p8�    $   res://chess_pieces/chess_piece.gd         �      �YmZ/�<5�E�.�%�    ,   res://chess_pieces/chess_piece.tscn.remap   �      h       /^	\�R�2DT5���    (   res://chess_pieces/move-self.mp3.import �'      �       *�+��@�}`�"�l�n    ,   res://chess_pieces/moves/pawn_movement.gd                 L�q�=�mO	��n�$        res://chess_table/chess_table.gd�(      �       ������ru�J�:��{    (   res://chess_table/chess_table.tscn.remap��      h       �W���9��R�a�5{    $   res://chess_table/node.tscn.remap   ��      a       �꒰�R��jH��    (   res://chess_table/tile_map.tscn.remap   `�      e       �`콰-�9�6�� ��    $   res://controllers/chess_move_area.gdPL      	      ���S��`L�Ds�p��    ,   res://controllers/chess_move_area.tscn.remap��      l       ߨ��g�2��[�$Va    $   res://controllers/move_manager.gd   �B      ;      ˺��Q����q�[ʈ�    ,   res://controllers/move_manager.tscn.remap   @�      i       h���e�@�[{       res://icon.svg  ��      �      C��=U���^Qu��U3       res://icon.svg.import   @�      �       ��}S�f
�<�K���J       res://project.binary��      �      �P�ǋ\J��6��    4   res://releases/web/index.apple-touch-icon.png.import�k      �       l�nJ܈���
vU�    (   res://releases/web/index.icon.png.import�y      �       �,��M�+���3�x�    $   res://releases/web/index.png.import ��      �       ��b�_"gHi��:    $   res://shaders/chess_table.gdshader  P�            pN���ɒ}��x��}23    ,   res://shaders/selected_chess_piece.gdshader `�      �      "܍���*�'VL��    (   res://textures/chess_pieces.png.import  P�      �       �&3B��.F��'�    (   res://textures/chess_table.png.import   ��      �       \T��5����|Zc�    �0n��.���L�extends "res://chess_pieces/chess_piece.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
G��@tool
extends Node2D
class_name ChessPiece

enum TYPE{
	PAWN,
	BISHOP,
	KNIGHT,
	ROOK,
	QUEEN,
	KING
}

enum COLOR{
	WHITE,
	BLACK
}

#https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_basics.html#properties-setters-and-getters

@export_category("Piece Properties")
@export var type := TYPE.PAWN :
	set(value):
		type = value
		if sprite != null:
			updateSprite()
		
@export var color := COLOR.WHITE :
	set(value):
		color = value
		if sprite != null:
			updateSprite()
		
@export var spriteFrame = 0

@onready var sprite = $Sprite2D
@onready var audioStreamPlayer = $AudioStreamPlayer
#@onready var animationPlayer = $AnimationPlayer
@onready var animationPlayer2 = $AnimationPlayer2

var clicks = 0
var selected = false
var hovering_over = false

func updateSprite():
	self.spriteFrame = self.type
	if self.color == COLOR.BLACK:
		self.spriteFrame = self.spriteFrame + 6
	sprite.frame = self.spriteFrame

func move(position:Vector2):
	self.position = position

func getPosition():
	return position

func _ready():
	updateSprite()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if selected:
		sprite.material.set_shader_parameter("width", 2.5)
		followMouse()
	elif hovering_over:
		sprite.material.set_shader_parameter("width", 2.5)
	else:
		sprite.material.set_shader_parameter("width", 0)
		
func followMouse():
	var mouse_position = get_global_mouse_position().snapped(Vector2(64, 64))
	if mouse_position != position:
		animationPlayer2.play("wobble")
		if mouse_position.x < position.x:
			sprite.flip_h = true
	position = mouse_position
	
func _on_area_2d_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("left_click"):
		audioStreamPlayer.play()
		selected = !selected
		print(position)

func _on_area_2d_mouse_shape_entered(shape_idx):
	hovering_over = true

func _on_area_2d_mouse_shape_exited(shape_idx):
	hovering_over = false
p�!�RSRC                    PackedScene            ��������                                               	   Sprite2D 	   material    shader_parameter/width    Area2D 	   rotation    resource_local_to_scene    resource_name    shader    shader_parameter/color    shader_parameter/pattern    shader_parameter/inside    shader_parameter/add_margins    script    custom_solver_bias    size    length 
   loop_mode    step    tracks/0/type    tracks/0/imported    tracks/0/enabled    tracks/0/path    tracks/0/interp    tracks/0/loop_wrap    tracks/0/keys    _data 	   _bundled       Script "   res://chess_pieces/chess_piece.gd ��������   Shader ,   res://shaders/selected_chess_piece.gdshader ��������
   Texture2D     res://textures/chess_pieces.png ��(z/�nw   AudioStream !   res://chess_pieces/move-self.mp3 ,�xd`      local://ShaderMaterial_xd1pn �         local://ShaderMaterial_ec586 �         local://RectangleShape2D_gvtph �         local://Animation_msegy *         local://Animation_3vvie P         local://Animation_fpu6k e         local://AnimationLibrary_g6p3y v         local://Animation_5mta5 �         local://Animation_dwsjh �	         local://AnimationLibrary_3gghr B         local://PackedScene_qgl26 �         ShaderMaterial                            2     �?��L?      �?         @	          
                            ShaderMaterial                   2     �?��L?      �?         @	          
                            RectangleShape2D       
     pB  pB      
   Animation          o�:      
   Animation 
            not_selected       ���=         value                                                                       times !                transitions !        �?      values             @      update              
   Animation 
         	   selected       ��L>         value                                                                   times !                transitions !      ��?      values                      update                AnimationLibrary                   RESET                not_selected             	   selected                
   Animation 	         o�:         value                                                                    times !                transitions !        �?      values       )   �����?>      update              
   Animation 
            wobble          ?         value                                                                    times !          ���=��L>   ?      transitions !      d�@  �?�$#?  �?      values       )   z ���!�?)   �����?>)   z ���!�)   �����?>      update                 AnimationLibrary                   RESET                wobble                   PackedScene          	         names "         ChessPiece    script    Node2D 	   Sprite2D 	   material 	   position    texture    hframes    vframes    Area2D    CollisionShape2D    shape    AudioStreamPlayer    stream    AnimationPlayer 
   libraries    AnimationPlayer2    _on_area_2d_input_event    input_event     _on_area_2d_mouse_shape_entered    mouse_shape_entered    _on_area_2d_mouse_shape_exited    mouse_shape_exited    	   variants                           
          �                                                                                         	         node_count             nodes     I   ��������       ����                            ����                                             	   	   ����                    
   
   ����                                 ����                           ����      	                     ����      
             conn_count             conns                                                                                      node_paths              editable_instances              version             RSRCM�6#��e0���3N�RSRC                    AudioStreamMP3            ��������                                            	      resource_local_to_scene    resource_name    data    bpm    beat_count 
   bar_beats    loop    loop_offset    script           local://AudioStreamMP3_law0x           AudioStreamMP3          i  ID3    TENC     Pro Tools TXXX   #  originator_reference aaO4Kt!BKvSk TDRC     2019-04-21 TXXX     time_reference 172800000 TSSE     Lavf58.29.100           ��T                                 Info        � ------------KKKKKKKKKKKKiiiiiiiiiiiii��������������������������������������������������������������    Lavc58.54            $�      �z-/!���d  .ȅs@*�Vr�� ��OY����bC5  0� t.cR9�F��h䱟��7C�n�q��)&�L�61a ɃA	��y��	JaA����4�  P	{;��9z����r�|����zzzzJJJL    T��Y�q8��0��>�}@�@@�w�������b3����  }��� l ��1T��b����&sI�Q ���$gW	�S�u�$@�.@��9hՠ��Y�����XKn�8[`5��nn��b���5k*�ҙ�ւ�[�����\�����K�����=o9sn��x����Y�@e[�,���L����$���,K��C�wr�d�2�=W��ʪ ? @��@r����(�50����d
���<Jr  0��� 4�-�t@�	����cF� ��!a���R��fa! �*b Ɋ B��1j����G	� �� �MFT���Np鉪�J��dYN��IKRIk���Ѥ��ԟ�Z��h��L�f����� �U(��C�/ґ3�CVZ��MR��)�x��e���m�Wh����k���� �r�L� L���@HT�3�r45���7�3Z�2Br ��f��4Hū+3Zen�0 � lH�E��D�T/H(�.��(�H�ӯ�oT\�5Y�^��,Prw�A)R<z���R�i2��1�Tq�}p��#Pn�]TQk R6� 
�7�4LѠNH�|f�:�c�f�L`����d��_"�x+@4�x�c):�O-e�����A�!���4)����5����@�Vy�e-�X,
B�:��r%�Y��dyh$��2G����H�.��,�н��z���du�*�L9"�AB)�]���Ic�"2��1	
E9b�j��䈨d���4jӎ�R�"�?j �����yӪtր��'G1�Xqs�vbi�1F���g6��� ��˽9k�+�������T�$qژ���G���W��l].�1�z������)�yX�s`����tÉ�5�L�� V&��0 y�
�a�����~����ɧ��Kt/�h�IjBP�,K�B���
Jm�,*`ўg,��xp���H��JME��pY�e�:�B�>4n,����d�� B�zYpI�0gxxO-sF����żh�G�'n:�������r�S]rU�Q^��L+�5���e�.��1�;A/����!����UL��Fn`��@e�5b�ւ�4��%

h�eQewO���V��4l?FI��� Q�Q ���a:@�I W�*���*�(P�ab�4��,a2G��#j���!h��ۿr�D$q£K+yP�Z-��-����$K*�m���g���-�q0c3h���6��#��Xq�&D��XC& �APB[/�;fk̪�����U�ѹ�k#@f�P^v��#�d���6hL�
b<ǌtP�s)��"��e��xĊ�1(ɕ�������ˀPs�Ui�&���^��]������d(����zc0M#�o'hLh��m�AM���%�o-[�?���}@�c%L�čq���̱�z`��T�`��N�@I`�0�H�4�2�T�F �!밅1X*/,���梛o8���-
V6'�$$�NL�6:�␃�N~�4V�2����H� 
�N��Î���ƉL <=G4�KQe�� a�n��7�]�b��nf-=gZK�@�I���Y�!��)�&'��f�z` �$|�VN4��O��̥Ê@@x�e0Kr�¨G7U�˙�h-A#8��/J�W���W�6�Ռ�H����P�� ��~t�`鳭}<�c�A8';1��-61���3sB#`S�U�j2�2 x���{��r@��5g���d&�� >�y3�V�o����i+A4�_����SO��_��H$�EmSh_D�g$DP�.e�RDE�;�i��&0`t�fZ`DG
�2!�R0@ ���L0t���(��=%{%S1�K)d�v��ػ*h�p-���T� a�MF|��(�1�8Ѳ�5 T�2AB4g�	��h+�A���AY�N`��P%�N��gdHs���
@�d-����g{W;����]X���Og|IUU�F4\e�Ɩ�y� E�jR�!G	5!S3bq�opB�U�d���i��h�m�y���N*s\�� �EP'muF����L� K��D��d�M\���Aq��oĆ&�d��aק���� P{��?�%M�����C[�[�qc���2��I����d&�� =�y3�TC��sh>
P�o!�T��q�I1�?��	E���ga�T(�h���l��hu,�hXaADх�/@��`\
,�0h@�$ҽne�j��a�UY�ܳw�spm�AK4�N�̀�<��R����ͽ ��B�	��Lӆ�(�ɘ,H�� �B( ���ZqY��#��߫�����U�ڢ�R6�$�0H �CQa9����v���e�Y���R�r�N�<��"<��6��U������ �f��@+k���#�I��/gY�f��+w���P��,�0'�9# �|i��`잢'@�SI�`E�55q�
5�|#,՜
*�.�	T���P4�[�]٭kf���URItaU_7�L<�V�҄���D-��_��[�I�w k,X@ �      4�  4�M|�pٯ�;�2��4	��

.�4D3%��I=�z���.l��cĆ�1ۿ�}D�LAME3.100UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU         RSRCD��E�[remap]

importer="mp3"
type="AudioStreamMP3"
uid="uid://cfetd1g6xfmy"
path="res://.godot/imported/move-self.mp3-5dfe84bd17722bc9270c00455c93cc3b.mp3str"
 >�9�Xextends Node2D

class_name ChessTable

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
8RSRC                    PackedScene            ��������                                            
      resource_local_to_scene    resource_name    shader    shader_parameter/fov    shader_parameter/cull_back    shader_parameter/y_rot    shader_parameter/x_rot    shader_parameter/inset    script 	   _bundled       Script !   res://chess_table/chess_table.gd ��������   Shader #   res://shaders/chess_table.gdshader ��������
   Texture2D    res://textures/chess_table.png ��{���Bn   PackedScene $   res://controllers/move_manager.tscn ���P�d      local://ShaderMaterial_mi5o3 �         local://PackedScene_1q27m �         ShaderMaterial                        �B            )   	\?��>   )   	\?��>                   PackedScene    	      	         names "         chess_table    script    Node2D    ChessTable 	   material 	   position    scale    texture 	   Sprite2D    MoveManager    Pieces    	   variants                           
     �C  �C
     �A  �A                        node_count             nodes     &   ��������       ����                            ����                                       ���	                        
   ����              conn_count              conns               node_paths              editable_instances              version             RSRC֪�'RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       PackedScene $   res://chess_pieces/chess_piece.tscn �!���n�      local://PackedScene_ch0ad           PackedScene          	         names "         Node    Node2D    white_rook_1 	   position    white_bishop_1    white_knight_1    white_king    white_queen    white_knight_2    white_bishop_2    white_rook_2    white_pawn_1    white_pawn_2    white_pawn_3    white_pawn_4    white_pawn_5    white_pawn_6    white_pawn_7    white_pawn_8    	   variants                 
      B  �C
     �B  �C
      C  �C
     `C  �C
     �C  �C
     �C  �C
     �C  �C
     �C  �C
     `C  �C
      C  �C
     �B  �C
      B  �C
     �C  �C
     �C  �C
     �C  �C
     �C  �C      node_count             nodes     �   ��������       ����                ���                            ���                            ���                            ���                            ���                            ���                            ���	                            ���
                            ���             	               ���             
               ���                            ���                            ���                            ���                            ���                            ���                          conn_count              conns               node_paths              editable_instances              version             RSRC;16��°2�CRSRC                    PackedScene            ��������                                            "      resource_local_to_scene    resource_name    texture    margins    separation    texture_region_size    use_texture_padding    0:0/0    0:0/0/script    1:0/0    1:0/0/script    0:1/0    0:1/0/script    1:1/0    1:1/0/script    2:0/0    2:0/0/script    2:1/0    2:1/0/script    3:1/0    3:1/0/script    3:0/0    3:0/0/script    script    tile_shape    tile_layout    tile_offset_axis 
   tile_size    uv_clipping 
   sources/1    tile_proxies/source_level    tile_proxies/coords_level    tile_proxies/alternative_level 	   _bundled    
   Texture2D    res://textures/chess_table.png ��{���Bn   !   local://TileSetAtlasSource_w8rrd V         local://TileSet_fwhks 9         local://PackedScene_324ri q         TileSetAtlasSource                    -                         	          
                                                                                                               TileSet       -                               PackedScene    !      	         names "         TileMap 	   tile_set    format    layer_0/tile_data    	   variants                          �                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               node_count             nodes        ��������        ����                                conn_count              conns               node_paths              editable_instances              version             RSRC�&RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    size    script 	   _bundled       Script %   res://controllers/chess_move_area.gd ��������      local://RectangleShape2D_nblar g         local://PackedScene_inksl �         RectangleShape2D       
     �B  �B         PackedScene          	         names "         Area2D    script 	   Sprite2D    CollisionShape2D 	   position    shape    debug_color    _on_area_entered    area_entered    _on_area_exited    area_exited    	   variants                 
      B   B             ��Z?��x>��1?���>      node_count             nodes        ��������        ����                            ����                      ����                               conn_count             conns                                         
   	                    node_paths              editable_instances              version             RSRC��►y�extends Node
class_name MoveManager
@onready var chess_move_area = preload("res://controllers/chess_move_area.tscn")
@onready var tilemap = $TileMap

const chessPiece = preload("res://chess_pieces/chess_piece.tscn")
@onready var pieces = $Pieces
#var piece_positions = []
# Called when the node enters the scene tree for the first time.
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
			piece.position = Vector2(64*(column+1),64*(row+1))
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

l���(RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script "   res://controllers/move_manager.gd ��������   PackedScene     res://chess_table/tile_map.tscn sn}Uc+      local://PackedScene_asup3 U         PackedScene          	         names "         MoveManager    script    Node    TileMap    visible    scale    	   variants                                 
     �B  �B      node_count             nodes        ��������       ����                      ���                               conn_count              conns               node_paths              editable_instances              version             RSRC����extends Area2D

@onready var collisionShape = $CollisionShape2D
var color = Color(0.1, 0.1, 0.3, 0.5)

func _on_area_entered(area):
	collisionShape.set("debug_color", Color(0.4, 0.0, 0.1, 0.5))

func _on_area_exited(area):
	collisionShape.set("debug_color", color)
#��aG�GST2   �   �      ����               � �        ,  RIFF$  WEBPVP8L  /��,͘i�6�f����Ū��W�l�l$A���)�@���6��p��s Fm#I
����n?B��q�8�ۆ8����E�=4a�9����B�/�@�����H�p�@���ϑ�U�f�; d�� &S8�� ��2\�.��L^��F2'v�Qwǵ&bضmf���Zܶ�$�NMO����;�Kv�mk��RHV�p���033��ޠx�2S�`<��m�HR��{��7���Om�m�~���H2�CNS�۝��dfZ��o�\�E���(�\H�$�f���&�I-a��m��6����}b33̣3�:��f�0H�%G��ɶU۶m�S�s��m'��Bi3�^s8pI�\��u��9�m��27z#r���_�	��=x-x!��^�Rw}v��R�܋Í%Ƕ���X����	�ԉƭ��p�E��$I�D���;���/��ڶ������$���b������%�to� � �� ��ع�,���%��hD"(��&���x�w�����������w{���m۽  ���͍�oN�N�9�"F�P ���¡��7��A	c���6���À��� ��6�n���Yz�cZЏ�F�c�:wO��ήҲ�"��~ĳ��}t�;`�ѯ�w��v��B4��\��<;�E eyL˫�o7�-�n'��w7��rs�jP�~0����:)ZB�@� av��;�_^�{��޵��u��#F�t���-����"� �((�h����  Ԣw��������qgU}� }�wW�w�>}?����]DTUU�:R#���*Դ1�4�JD  BD�[5O_�<�ww*ԅ�o��ѹ��F��)�Ek4UT��EP
2���n���2i������E�=۾Y�Y���|��M���r�n�I5ESTF!�  PcD��Rmc�7��@�M����o<V��n��m�۶{�߶�g�`"��֭�Ѫh��RA@��Q��d�VU��V[[���^ue�C��۽�oǿ}��+�BG�F[E�����j҈:�zl���5At��^�f��uRT��FSEP,���iK������/�-���m�d��g��I5F[E� �h��H
 !Zrg��f��&�ad��e������)Ƌ� �V�/����,#�]Sk遌�MY���h�JA�Tm�� ����q`e�� ��D��R� ��C����{��4�( Q5UP@�h��@��i�yv���_�I�eUE���H1�r�-�{��u��E�(!A4��eFЉZ ��PD]T"�ԡ��`!�H�A@�hDf0J@!M;��4��N:ʸ:} ��G�(�nD���c$ ��� ����GCu����˭i#S.bV3s�1v��
���>����$'���6����"�-R�)؏�#Q8%�Bפ��Ժ`�U�jh���t�
 �,�˺����b���ր:�&B\iѷѾ'��ih�ݕOҴ6nNi9vǹ(Ӫ̷zZj�N� o'
\���<3R� iYg�u�B%��N������ẽ�
�*a��Ekס.��?ϗ�r�`^9����um5-ƶ��������T�r�w}�������8�8����*������{���A�D�$�����l��%S�v��SP8�aWկ���O���I��H��Y���KNL�Ϧ�*%��-���ieok.\�p�O�����&-���qTtf唯�E��ObB�&$:a�c�����X"�\l�]EW\8��\�g�"LF"K \lY,.#W��s�*:���ه˅$lM	W��HW>�\��;S�� ��� og[&\�ĕb��v��Ť��4[E��$}*��)K�l�S��B'Ϊ�,����~J
Q��nL�"u�;k�&�R�RL���\;=��ڥT$��nk��!�l�B�dG��!kQ3��?�%���i�k<�wޝ݀�I2�H��rCx"�@��[�^&gv8N+b�r�6wCӒ�G����_#d��n�;�p߃������b�e-�q��.ƹ����.�n�ҥ�'�Y���Y�J�*�[��F4�j�Z��U8A��6��Q5F$u^L�9Iq ��]�vi.P�Pj5d�1d ����o��5���j���*x��~77�+�mp�N�W� I�{��^��4j��õ�z[Q��=�����}۪��ر�ۻަ ހ(��}{�<��������R*O���lc{c�noݥD�W����ٽ}M	W�c����� ~u����"�R��9!h0Z;k�v�殻ת���p۠	Q����"j��j ���C�uom+t��(�M��y*iȀP���ۃ5Xc�
"	�:K&�W�t��?�"����#U?z��MH���bk��
N��m�&�]�ԑ&m����c[�W%*Pa��]�_}������n���Xg*�柮���?��s��1-P���������ٺL����i��]|n����rRgYT�-^4�����K/�xU�ANUw����K/����9�4&U�<��;��f/+���y�O��'˧{��w�f�B�.�"����UI<�d�w����w�('�y���s��W���������X�U��/8���?7wRX���%��UA�(y���6��KU`�˼���������]���������,x�ۿ�S�ݷ�f�z���|��I��M�&�<������j4�e��\|GLE�w���dP��s�~�}�a�|⛝~y溂/�ss�P�q�KO�}|�K�)wݛt�/!�i(a�i���O׸.�H6�����>1��<�-�g�P�Pj�m����S��w$��<������׿e�,��f��M�_m��Ӻ�>�����n���������^����F��΍�׷����ZW���b�U�?�_��o��G���ܸj�y��6�׾)8�ւ��uG����6�/��Q�;���/�_��u[n�������U���"�l���/��&\C4��5���꣪
�����}�%���S�����U�^U�tS��6���_3xR�fE���y�Ԉ��r�����X�W|ޝ�y1-���]�uo���6��'7�;����W�����>�=�N�y��݄m� B$ЭݽU�L��'�L^տ q���1�t�%L�!��7��}��˶_ֽ)J�^PG�L�G���}�lg|�}�g:d
hX��<ܽ˘��Nmm>e׸�{_Ҿ���Q�/�/Vy	��]��p,@����y)�l��F�=�qE�L�/�~��T���Cb  `�_����� Եx�F���Wm�(� �I��[�\kb8�_�
�0��'��Q�%G�گ~�?�A�����w����o�~D���\�����c|��UG�9�+�{���=4 �݆���-�e�G�WQG�#��>�k��Ϻou���?i\׹��֪]�{��7M^��gM^v�u�ߨ]���k���R~����pM�_�ݟ�sȪ��y5�|��(22`9�?�c]�S��OlLp��	�V��_��h� @�΍�_�q�Z��=.8��z�֌ 0Oy�� T;����(� ��eY_f�X�q�K2kyGݛԩ+[�{�w��RW�J9b>�����	w� �_�&u��\ ֳ,�%2���Z�ԑ�7�����72���b��)%����&���@�C��qADV�T�.�\k��Be�A�p��D��  Qn�a�!,*��-&�v�;�r��w�<��c�a��wnw嚗Rn��- �ڍWs�E�I��a���no/�����l�+K���V�W��o���s�رve���Cߛ�_����g����u^=B��ױ	�����*�y�U�C�:����_�w������[����_�~�u<���Rf��O����̮=������v���29��F�9����< ��S��/�����X��ޯ�������d;T�����;�Gs�o���������K�XC���&Vr���y5�r��;s{�_�,��~���W���{���ʵ���Ǉ��o������n���ܫ�o`؟X�?�n��ֻI���Z^r�ڭ�w�z��I �\�'�f`�\��ӾwW���/�����}�랿vqs�;�:�?���?����/?���o��Ľ��t3�O����m�����v���䉋G�����k|�{��������~���%�*�Q�/���|����=��o~�o|��W7��L�������~��w��/��7�/�nFZG����?���_��}������u����{�~g�n��3�Ѽ%��9�g�׏Ϋ�dy�����q�Ooy!��S��ڭ·�|�w������(��e�}�]���Y'�s{IO���m���n�A�C�=�������t~ [s{:��P	G�ɸ�m�wV�%�� ;8�+Y�u<}�}1��.����Օ�!*�eqD�HJ�����'6>Ը�p80��Y]��ϳ<;6�8U �uX_�M�m��+
A�37��G9��ʮfj�qH�cj*��B\s^�өs^��'��a0;��p��2��'�q�j��E}m�K����S�Ӵf�r��N �l�a�
�'�]��唣����w0�ǧq~!zNVj��s�}6���2��s^�����N�V�E���Q^}�1�����<��E��_s��D��F�~��ּޮ�u3=q���8��]��#�[����$^�ڢ	�xIR'EX���۰?�"i]��q;'���q�s���!LD�DDC4���׃R,�d|�{'����eϳ��e�R�e�;W�+7��͹�-�UI�Ȓ��&�X4�%�!����G���Gr��o��WT���t��~�qa��ki�*�ŉ���I�,9��ʡ�թ���/_�|��K� �� �����(�`���֔p��b;�ϖ�-+g&g�'�u�@X��x���$R�Đ�Ȓ����o?��G�ŵ8�JQ
�"X��r�8�m Ac��)���uG5��ܡ��2�p\\ܲî������/�{~��dQP�v�P�C�A@�lmA�����v����N��q���!��hw_�����OX���2#�dg~����<N�8�����)w�@��C���J��J����_2Ob�G�����)�$�}1Eʳmv`%�d9��f��$��!iILYx����я�{~�u����Mw`�,�B�G�P��s
E{���x��1V��@N���O�sR&9d�����?;3�ҤI��&�ݥIca�Uf���$S�u��.&��#Ym��e�c��"|�nf��NN�q8������T!�L@�U��R�λ3��>T�|�3�B'*G4�vnL2�|`y8�b@s�tDae��)X� �5_�M�IM��6���J C�s�Q�2��s�)O�x�V��@�$�LR:*��^�i�������J|��*KvO
 �ȑ�ϸ=�����0�����2y:*���R�@�8�0��'+c٧@����;={z<���ً��2�.��  �,��,�B� `���(��������(�Y�d.�0-� p�YI�����c�/���'�L�LX+}y-����?�u�VS����l5h�
8b%e]6��g��F�j��}�$2��|dI[}��d$2�Y��?� �T����i�/�)�2�2s�8���Ŕ��$��s�d*)So֚[�$ ��
[���\����=|E��o�����&�4QBj��D�
�_|� ����)[��O��_�7fg����4_�/���ï��  `��b�ba�bxcV�A]L]��]���{ ?����Ѓ��� 	ABd��.#$AB2�F�գ�i�z5P���= Y§��������~�(9[�w�ޞ�/?c��z c��^R��O�ų�=��5Y�]��)�y��ɢ.�|�/�?����8�M�8�$�5:3q3:� 5 ���N~�1�Q���n��#K��3�ČV�FΊ1#1�߇���7�g�𮖅`�E	(>�u�g~��H�+�͂��Wϻ�����=J_O_ϻ�]��ߏ
x�V_��a��;7ۋ�}�<ʿx�4?���Z�[�]�n���u�nc����u�-�l�B]k�7�ߨ� YD	�]�@	�t�p_K�L4�A��h���z;M��j����bꂺ����?�;���m<y��s?�{��a{�9bFΊF�jb�,����I4�R1d�����Ҕ�@��[]7�O���b���ҏ�9�G6l�ׯ�Λ��6~�g��_Ɵ�yaj�@Ge4bgm������[$g�� H&ģ	(G��lO��D(duv�@YRg�D͝G%X2~�Ҁ&�w-yV蜼e;P����jS~�dl�խg[��r�Zּ�eK��j�.����k1&iY@	Ӷ�\�R�D_����Yf�$��~��؆�iP	�u�uZ(g E�ڴi[�<��-�vf���#�(o���n�h�$��4BD*�e�6��s6�ԁ���n�`J�4<,q\�k߻�5P�<�
�ע��%(�g�2o}m�բ,��H��h���HK�����n"�A��V����ղ�".W�BԬC�5���0*�H���LD"C"�b!�=_&�����@�2!E`5�[M�47Z�&VX���h-{�a�����)!K�GKˏ�CI�v
���d��a0a	+\��JEi�ЖOd��
����'�4�gj�@G "� �;l�8��Ld����R�B���TX+`tIr9A� D&J�%:i��ɞ��˕�3��g�<&��P� ��- LA�(�*p���ŕ�D&2�� c��T�g�@iE��#4 �)���4SeG21���&4��H�H4� c�B�v���6*#F�N0�OLa�.F��*�"B1�[h�=1EӸՒ"��$R�(�?�yg�s�� D%no�T	73x0hH2�e��e���<������( �4'�#�Og�P{���vv�0}�Ť1j�ە@�S�( �r�Vo��
�ز�B^!�qc����6�Z5 ���"��l`y����t� ������h��U�*���������7�-�wN�ۭVŤQUQ�X��� rIr�9�*  ��v���j�5D Ŵ��R�:+<h�"?� Dۢ�--@4f�CDw��;��Vc��T�VQ�F�5������3�M�μr ��~���~k�<� b H��Q�$B�gg"�+s�U����յ|ߦ��A�3�r��s�}���"��IW_P��T)�pB��R	@J*�S����]�:bKW��� L�1إq�����l����c=DtDU�fQ��Ҏ J��*S:�T8!;�Gl���*��:�����������jk�����"�� �(���J��@�چ ������������G�5��pY�����k���]O��B��-��E�l��Z�o�W�x���������� _xՕ��kr�R̝�,# A��#��hK��ni��l�ktx�ч���k��!�-���fd�k*��~�̡"����ͱ���������`.���-}�����ɮ�'s�Ф�Mg�!�:d�� R�� la.��t�}�V��6m@e�u��߃�gڏ>l��k�����-�qh�n��w/fFЉF4�Q)��am�G�y:խ��+ `�e� �5��   �{�|���Kq�[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://db8yjqexepgpv"
path="res://.godot/imported/index.apple-touch-icon.png-aee0db1fcba6b98a735f2f7f22b48105.ctex"
metadata={
"vram_texture": false
}
 ���K?��-�-,�GST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /������!"2�H�$�n윦���z�x����դ�<����q����F��Z��?&,
ScI_L �;����In#Y��0�p~��Z��m[��N����R,��#"� )���d��mG�������ڶ�$�ʹ���۶�=���mϬm۶mc�9��z��T��7�m+�}�����v��ح�m�m������$$P�����එ#���=�]��SnA�VhE��*JG�
&����^x��&�+���2ε�L2�@��		��S�2A�/E���d"?���Dh�+Z�@:�Gk�FbWd�\�C�Ӷg�g�k��Vo��<c{��4�;M�,5��ٜ2�Ζ�yO�S����qZ0��s���r?I��ѷE{�4�Ζ�i� xK�U��F�Z�y�SL�)���旵�V[�-�1Z�-�1���z�Q�>�tH�0��:[RGň6�=KVv�X�6�L;�N\���J���/0u���_��U��]���ǫ)�9��������!�&�?W�VfY�2���༏��2kSi����1!��z+�F�j=�R�O�{�
ۇ�P-�������\����y;�[ ���lm�F2K�ޱ|��S��d)é�r�BTZ)e�� ��֩A�2�����X�X'�e1߬���p��-�-f�E�ˊU	^�����T�ZT�m�*a|	׫�:V���G�r+�/�T��@U�N׼�h�+	*�*sN1e�,e���nbJL<����"g=O��AL�WO!��߈Q���,ɉ'���lzJ���Q����t��9�F���A��g�B-����G�f|��x��5�'+��O��y��������F��2�����R�q�):VtI���/ʎ�UfěĲr'�g�g����5�t�ۛ�F���S�j1p�)�JD̻�ZR���Pq�r/jt�/sO�C�u����i�y�K�(Q��7őA�2���R�ͥ+lgzJ~��,eA��.���k�eQ�,l'Ɨ�2�,eaS��S�ԟe)��x��ood�d)����h��ZZ��`z�պ��;�Cr�rpi&��՜�Pf��+���:w��b�DUeZ��ڡ��iA>IN>���܋�b�O<�A���)�R�4��8+��k�Jpey��.���7ryc�!��M�a���v_��/�����'��t5`=��~	`�����p\�u����*>:|ٻ@�G�����wƝ�����K5�NZal������LH�]I'�^���+@q(�q2q+�g�}�o�����S߈:�R�݉C������?�1�.��
�ڈL�Fb%ħA ����Q���2�͍J]_�� A��Fb�����ݏ�4o��'2��F�  ڹ���W�L |����YK5�-�E�n�K�|�ɭvD=��p!V3gS��`�p|r�l	F�4�1{�V'&����|pj� ߫'ş�pdT�7`&�
�1g�����@D�˅ �x?)~83+	p �3W�w��j"�� '�J��CM�+ �Ĝ��"���4� ����nΟ	�0C���q'�&5.��z@�S1l5Z��]�~L�L"�"�VS��8w.����H�B|���K(�}
r%Vk$f�����8�ڹ���R�dϝx/@�_�k'�8���E���r��D���K�z3�^���Vw��ZEl%~�Vc���R� �Xk[�3��B��Ğ�Y��A`_��fa��D{������ @ ��dg�������Mƚ�R�`���s����>x=�����	`��s���H���/ū�R�U�g�r���/����n�;�SSup`�S��6��u���⟦;Z�AN3�|�oh�9f�Pg�����^��g�t����x��)Oq�Q�My55jF����t9����,�z�Z�����2��#�)���"�u���}'�*�>�����ǯ[����82һ�n���0�<v�ݑa}.+n��'����W:4TY�����P�ר���Cȫۿ�Ϗ��?����Ӣ�K�|y�@suyo�<�����{��x}~�����~�AN]�q�9ޝ�GG�����[�L}~�`�f%4�R!1�no���������v!�G����Qw��m���"F!9�vٿü�|j�����*��{Ew[Á��������u.+�<���awͮ�ӓ�Q �:�Vd�5*��p�ioaE��,�LjP��	a�/�˰!{g:���3`=`]�2��y`�"��N�N�p���� ��3�Z��䏔��9"�ʞ l�zP�G�ߙj��V�>���n�/��׷�G��[���\��T��Ͷh���ag?1��O��6{s{����!�1�Y�����91Qry��=����y=�ٮh;�����[�tDV5�chȃ��v�G ��T/'XX���~Q�7��+[�e��Ti@j��)��9��J�hJV�#�jk�A�1�^6���=<ԧg�B�*o�߯.��/�>W[M���I�o?V���s��|yu�xt��]�].��Yyx�w���`��C���pH��tu�w�J��#Ef�Y݆v�f5�e��8��=�٢�e��W��M9J�u�}]釧7k���:�o�����Ç����ս�r3W���7k���e�������ϛk��Ϳ�_��lu�۹�g�w��~�ߗ�/��ݩ�-�->�I�͒���A�	���ߥζ,�}�3�UbY?�Ӓ�7q�Db����>~8�]
� ^n׹�[�o���Z-�ǫ�N;U���E4=eȢ�vk��Z�Y�j���k�j1�/eȢK��J�9|�,UX65]W����lQ-�"`�C�.~8ek�{Xy���d��<��Gf�ō�E�Ӗ�T� �g��Y�*��.͊e��"�]�d������h��ڠ����c�qV�ǷN��6�z���kD�6�L;�N\���Y�����
�O�ʨ1*]a�SN�=	fH�JN�9%'�S<C:��:`�s��~��jKEU�#i����$�K�TQD���G0H�=�� �d�-Q�H�4�5��L�r?����}��B+��,Q�yO�H�jD�4d�����0*�]�	~�ӎ�.�"����%
��d$"5zxA:�U��H���H%jس{���kW��)�	8J��v�}�rK�F�@�t)FXu����G'.X�8�KH;���[ i���,�_Ǔ��Y[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://de181vammto8d"
path="res://.godot/imported/index.icon.png-c0bc0b5efb62fc2599b228707fd41b63.ctex"
metadata={
"vram_texture": false
}
 J�!��?%�OGST2      X     ����                X       �,  RIFF�,  WEBPVP8L�,  /Õ�mۆq�����1�Ve���G�N^6۶�'�����L �	���������'�G�n$�V����p����̿���H�9��L߃�E۶c��ۘhd�1�Nc��6���I܁���[�(�#�m�9��'�mۦL���f�����~�=��!i�f��&�"�	Y���,�A����z����I�mmN����#%)Ȩ��b��P
��l"��m'���U�,���FQ�S�m�$�pD��жm�m۶m#�0�F�m�6����$I�3���s�������oI�,I�l���Cn����Bm&�*&sӹEP���|[=Ij[�m۝m��m���l۶m��g{gK�jm���$�vۦ�W=n�  q��I$Ij�	�J�x����U��޽�� I�i[up�m۶m۶m۶m۶m�ټ�47�$)Ι�j�E�|�C?����/�����/�����/�����/�����/�����/�����/�����̸k*�u����j_R�.�ΗԳ�K+�%�=�A�V0#��������3��[ނs$�r�H�9xޱ�	T�:T��iiW��V�`������h@`��w�L�"\�����@|�
a2�T� ��8b����~�z��'`	$� KśϾ�OS��	���;$�^�L����α��b�R鷺�EI%��9  �7� ,0 @Nk�p�Uu��R�����Ω��5p7�T�'`/p����N�گ�
�F%V�9;!�9�)�9��D�h�zo���N`/<T�����֡cv��t�EIL���t  �qw�AX�q �a�VKq���JS��ֱ؁�0F�A�
�L��2�ѾK�I%�}\ �	�*�	1���i.'���e.�c�W��^�?�Hg���Tm�%�o�
oO-  x"6�& `��R^���WU��N��" �?���kG�-$#���B��#���ˋ�銀�z֊�˧(J�'��c  ��� vNmŅZX���OV�5X R�B%an	8b!		e���6�j��k0C�k�*-|�Z  ��I� \���v  ��Qi�+PG�F������E%����o&Ӎ��z���k��;	Uq�E>Yt�����D��z��Q����tɖA�kӥ���|���1:�
v�T��u/Z�����t)�e����[K㡯{1<�;[��xK���f�%���L�"�i�����S'��󔀛�D|<�� ��u�={�����L-ob{��be�s�V�]���"m!��*��,:ifc$T����u@8 	!B}� ���u�J�_  ��!B!�-� _�Y ��	��@�����NV]�̀����I��,|����`)0��p+$cAO�e5�sl������j�l0 vB�X��[a��,�r��ς���Z�,| % ȹ���?;9���N�29@%x�.
k�(B��Y��_  `fB{4��V�_?ZQ��@Z�_?�	,��� � ��2�gH8C9��@���;[�L�kY�W�
*B@� 8f=:;]*LQ��D
��T�f=�` T����t���ʕ�￀�p�f�m@��*.>��OU�rk1e�����5{�w��V!���I[����X3�Ip�~�����rE6�nq�ft��b��f_���J�����XY�+��JI�vo9��x3�x�d�R]�l�\�N��˂��d�'jj<����ne������8��$����p'��X�v����K���~ � �q�V������u/�&PQR�m����=��_�EQ�3���#����K���r  ��J	��qe��@5՗�/# l:�N�r0u���>��ׁd��ie2� ���G'& �`5���s����'����[%9���ۓ�Хމ�\15�ƀ�9C#A#8%��=%�Z%y��Bmy�#�$4�)dA�+��S��N}��Y�%�Q�a�W��?��$�3x $��6��pE<Z�Dq��8���p��$H�< �֡�h�cާ���u�  �"Hj$����E%�@z�@w+$�	��cQ��
1�)��������R9T��v�-  xG�1�?����PO�}Eq�i�p�iJ@Q�=@�ݹ:t�o��{�d`5�����/W^�m��g���B~ h�  ����l  נ�6rߙ�����^�?r���   ���⤖��  �!��#�3\?��/  �ݝRG��\�9;6���}P6������K>��V̒=l��n)��p	 ����0n䯂���}   ���S*	 ��t%ͤ+@�����T�~��s����oL)�J� 0>��W�-  �*N�%x=�8ikfV^���3�,�=�,}�<Z��T�+'��\�;x�Y���=���`}�y�>0����/'ـ�!z9�pQ��v/ֶ�Ǜ����㗬��9r���}��D���ל���	{�y����0&�Q����W��y ����l��.�LVZ��C���*W��v����r���cGk�
^�Ja%k��S���D"j���2���RW/������ض1 ����
.bVW&�gr��U\�+���!���m ;+۞�&�6]�4R�/��Y�L�Ά`"�sl,Y/��x��|&Dv�_
Q*� V�NWYu�%��-�&D�(&��"  Wc��ZS���(�x� ,�!����!�L�AM�E�]}X�!��wB�o��-  �-���16���i���ю�z��� ���B��oB�0������v]���ȓ�����3�� +S�χ�=Q_�����˨�d��|)D>��k ��uȣ���Y[9̂�����! ^�!��r���j0Y+i��΍e(�ț� ���x��
��{��<6 R���پ�b��Y
C����+���������;���a ���,�o��bC�{�?���1 �(��¤ �V�������;�=��I��� ���EI���Z��)D����t=S ��] X��9K�= �.~�K[��Ŋ��,2��� p}>w<n�g h�
�t���R�u�G�1k���!��x���������� �L���|>D�0�Ǣ(Qc�� ����= �ۊ�Z0�^��c �
|�����L�%�d��q���(�WB� ��(	���� �J��8D�0�~$�Dsy�Ѿ!������j�^ ��mOa�8.�qce��s|%Dq~,X�u�������=T	���Q�M�ȣm�Y�%Y+�[�0|"DΞ�j�u�L6�(Qe��qw�V�э���ǂ���!j�K � �:�wQ�dÛ������R�
��C���X�u�`����\"j讀Dq21� �F>B[��[������]@K-���C�e�q�tWP�:W�۞X�z��,��t�p���P��Se����T���{dG��
KA���w�t3t��[ܘ�4^>�5ŉ�^�n�Eq�U��Ӎ��α�v�O6C�
�F%�+8eů��M����hk��w�欹񔈓����C��y訫���J�Is�����Po|��{�Ѿ)+~�W��N,�ů��޽���O��J�_�w��N8����x�?�=X��t�R�BM�8���VSyI5=ݫ�	-�� �ֶ��oV�����G������3��D��aEI��ZI5�݋����t��b��j��G����U���΃�C�������ق�в����b���}s����xkn��`5�����>��M�Ev�-�͇\��|�=� '�<ތ�Ǜ���<O�LM�n.f>Z�,~��>��㷾�����x8���<x�����h}��#g�ж��������d�1xwp�yJO�v�	TV����گ�.�=��N����oK_={?-����@/�~�,��m ��9r.�6K_=�7#�SS����Ao�"�,TW+I��gt���F�;S���QW/�|�$�q#��W�Ƞ(�)H�W�}u�Ry�#���᎞�ͦ�˜QQ�R_��J}�O���w�����F[zjl�dn�`$� =�+cy��x3������U�d�d����v��,&FA&'kF�Y22�1z�W!�����1H�Y0&Ӎ W&^�O�NW�����U����-�|��|&HW������"�q����� ��#�R�$����?�~���� �z'F��I���w�'&����se���l�̂L�����-�P���s��fH�`�M��#H[�`,,s]��T����*Jqã��ł�� )-|yč��G�^J5]���e�hk�l;4�O��� ���[�������.��������������xm�p�w�չ�Y��(s�a�9[0Z�f&^��&�ks�w�s�_F^���2΂d��RU� �s��O0_\읅�,���2t�f�~�'t�p{$`6���WĽU.D"j�=�d��}��}���S["NB�_MxQCA[����\	�6}7Y����K���K6���{���Z۔s�2 �L�b�3��T��ݹ����&'ks����ܓ�ЛϾ�}f��,�Dq&������s��ϼ��{������&'k�����Qw窭�_i�+x�6ڥ��f�{j)���ퟎƍ3ou�R�Y����徙�k����X�Z
m.Y+=Z��m3�L47�j�3o�=�!J
5s���(��A ��t)���N�]68�u< Ƞ��_�im>d ��z(���(��⤶�� �&�ۥ� ��  Vc�8�'��qo9 �t��i�ρdn��Of���O�RQP���h'������P֡���n ���č����k�K@�>����pH>z)-|��B��j���!j:�+������˧��t�������1����.`v�M�k�q#�$���N:�����-M5a10y����(�T��� X5 \�:� ?+�7#�?�*Y+-,s� ~�|\)뀀ap �drn�g��RN�X�er ��@ĕ���;��z��8ɱ�����	�- �
�bKc����kt�U]�䎚���hgu���|�_J{ �`p��o�p�T�U��p���/���Hϑ�H�$X ܬm3���ŉ�U'��뻩t��G9�}�)O������p�΃g���JO���\9�׫�����ڳ�!k����/��9R���^�%��C����T���;ji<�>�KY����;�J��ƶm .P��pT��
@HA��r��98V���b�v���YwaZ>�$oւ?-փ��ʹ|0�.��3���b駁�c��;?8E;���V�B�؀����|%\\s��%����e{o��Z�i�������^���s�Jx������B jh�\ �h�<��V��sh@:���.�ІYl��˂�`3hE.,P�2^����J��+�����p��
�ЊJd��x�*�@�7R��� �"�G="!�� �p����u�o��wV�m�g���~F��?����/�����}~����sо7� ���\,,k�J�T�6������Z�y�rBZ[D�>v�HQ�R��mq�������DD�-6+�V`���J�E�����\� 9!ߑ�`��6���ml�~ZM�Z�ȎV���g���������3?*u3���ctW����YQa�Cb�P�,B5�p0�m�cͺEt�{,��>s9f�^��`OG��]����2�Fk�9_�G�vd��	��)��=�1^Ų�Wl3{�����1��H)�e������9�هZ�]}�b���)b�C��es}�cVi~x���e
Z�)܃��39������C�(�+R����!�j����F�n���<?�p��l�8a�4xOb��������c�8&�UA�|	/l�8�8���3t�6�͏���v���� ����סy�wU��`� =��|M�Y?�'�A��&�@*�c~!�/{��),�>�=xr"	�qlF:��L&���=<5t�h.�#ᣭ���O�z�!�&`A�F�yK=�c<\GZ�� 4HG�0i�F녠uB"���<��c�Jeۈ�3!����O��q萞PiZ&�$M[���(G��e���ؤ���ã��O���5����'�gH~�����=��g�F|8�+�X�4�u���G�2����'��.��5[�OlB��$f4���`��mS�L�,y�t&V�#P�3{ ��763�7N���"��P��I�X��BgV�n�a:$:�FZ���'�7����f������z!�����KA�G��D#������ˑ`ڶs���&� ݱ��4�j��n�� ݷ�~s��F�pD�LE�q+wX;t,�i�y��Y��A�۩`p�m#�x�kS�c��@bVL��w?��C�.|n{.gBP�Tr��v1�T�;"��v����XSS��(4�Ύ�-T�� (C�*>�-
�8��&�;��f;�[Փ���`,�Y�#{�lQ�!��Q��ّ�t9����b��5�#%<0)-%	��yhKx2+���V��Z� �j�˱RQF_�8M���{N]���8�m��ps���L���'��y�Ҍ}��$A`��i��O�r1p0�%��茮�:;�e���K A��qObQI,F�؟�o��A�\�V�����p�g"F���zy�0���9"� �8X�o�v����ߕڄ��E �5�3�J�ص�Ou�SbVis�I���ص�Z���ڒ�X��r�(��w��l��r"�`]�\�B���Ija:�O\���/�*]�þR������|���ʑ@�����W�8f�lA���Xl��촻�K<�dq1+x�*U�;�'�Vnl`"_L�3�B����u�����M���'�!-�<;S�F�܊�bSgq� ���Xt�肦�a��RZ�Y_ި��ZRSGA��-:8����yw_}XW�Z���-k�g.U��|�7P�
&���$˳��+��~?7�k�bQ���g������~�Z�e����H�-p�7S�� 
�w"XK�`K%?�`Tr|p���"��\�a�?�٧ ��'u�cv�&��<LM�Ud��T���Ak��������'+7��XR`��[\�-0���e�AiW]�Dk���$u���0[?�-���L����X�ĚSK-�.%�9=j�3t^���(c�yM-��/�ao����\%�?�б �~���b][
tٵ�<qF�)�
�J�'QZY�����*pB�I4�޸�,������.Т�1���/
t�1-1������E�*��Cl/Ю©f�<,0�S�bf�^���[8Z$��@���kw�M<?�[`��)3)1� �U����:��/pR��XV`XE,/0���d���1>ѫ��i�z��*o�}&R{���$f�JV=5͉Ύ��Rl�/�N4.�U~Cm�N~��HPRS�?G��g�-���qvT{�G _�[ua�;���kco�9�Kw����n����E{d�j��C���,q����Y���cwY<$#�ؤ�m+�LL-�z� �y<{/7���[��X�?�-6(cO ?�XZ�M�������sb�[
�.����j|;d�!0lCIqZ�z�&��~�|7�A���A~��á@�� 417��}t ��,� X�6��lS)6v�G
��I:�).~��8R���#'��߶;9�'���U�$1nC�L��찦3�+b黙u�NJ�����8���X�?5�0��^��[B/+�0�Ur(��J��+Xr�H�����HZm&�#�p	�Y ����*���hM]��m���b�ݢ����G����s��z-�x��������� �J�"���Ћ�g�Ҝ �Aа��?��?6��c�Zx�$�t��{s
-R�E�24�?�{�l�-��1�3S�EJ��v6X]L�B^ ��]N��R�yN��62�����'R�p-�����n2�d�?Th|�h��3X������Rc8&��_,��;T�8�� �hΗv�(7I;�3Obn;��O�!����Lߍ*�E~wU,���n�MN1���Z��Y̖��tY;5�^�<Z�Ǩ�T#�bt�xfA�n�cq����"9GD*�^JL��HJ���4���V�-�܉��4*��u]�[
���,"ҏ�i!�r~L��_�����8 ]j�?x���<k+%w��Bk��=�u�ڤ��>%2Bۃ�Y�n<jBo������Κ�0M~�t>�#b/jZ�}���B��Q��#���6R$v�����k�R$c/:�~���(V�7;)��ߊ[̣0?F��;.�*ݪd������{A`w>~�i=D�c��������Y2�X�q~�r2��8@v=f�?��X��S�"X�j?��@$?�����x�(�k���c7��\�����>A�=fpM?9d?�׻{���)f�.⪝���3�������f,N;"��,N���X��*�"V���"��C��?���(2=���A��1�Ul���h�8Ao(5X�B�X�>S�j��s�!
l����GgGp��>�v;c���V�N1���-��K�S�=6PiN�fNq������,
�3SWx�ei����f'�*�r�rʹ̙�e�7���b�o���>_i��M�_��V�p�r�9��X�$�����B���t5�4#�B(E���3�������`����I�M�e��b6_����{~�f/��@��B��Y����E�4��޲�d�O�$���M�����ݖv�P����TR�oj~��+}��#���"�]1Υ_���nR���œ����^pQ2�7첾b��3�ba�\��uu2�~O�G�����5�^>v������m��?���mC;$eT��C񎋋��V��8�:��
���ʱlt��~e]�cC7dl���.�i����\w����/..F�Q5���œ��`�o���E����E�͛�ٽ-�o�z�"n��/��[�����ͳI���S��Dڢ��V�6��!��esq��AC���ڻ���OMk�y��{7`c0�ٺ���5C5�yiw��`ps�OC��f�X�5oQ�\_*m�f�)稹"���a2$O;�]C�A�;V.���c��iޢ�R5�X��t%�s����ȸ�; 5�����)��X|?����9&��wĽjdn�{��7��/����q]3Ɲ�}�[��yF~�Q0����x��U�� ���˘?����a�;���/yޫ�����6.��C}���&L��9�_�ս�w�o���W�^�;�^u�xoݖ��Q8����4��kW��'����:9>����Xp5H��ONtL��=��_�&�0��H"Q��|H���4!���]�'�!޹Eܢ���}=soϢ~	K�$���`"!]j�+{'e�M��D]��=�>c��xS��Y����X��7�7+�Me̯/���u�Q����i���Eg�9�g�RU��#'��ޑW\r�aS�/3�"/v
IgX���}ٻ���ʏr�r���_��<�6�Gʋ&���z%�Pl^d����㑭v�ʎو�w�[���Q��k�K�����IWˈ��`/�Y�X��9J"��_��V{��je�i��6�<�ZS��� �t���W�Bg��@5���..��X�eʡ��*�HRgkD^>�y裝"�9�+wQ4ABR������^�k3�>2�����x�C�l���f:��#gщ�s� ��ߜ��ȁ���+���A��˾�g�1K9Cܹ��:���T"!I������Hs�;���ue��9@#ChE5&!��'�2�����w*a/Q��I	�E������I�w�����?��v })B��GQ�n�h"]0��]Z֑���.}�&~x2��
eĞsF�n�+�b�e�i����0Ix�y��Aѕ���
[1�B�R$$����:�4E疳��#�4���y���ӈ�6o1O�V'��7]�H�.)/)�OwW./�g�l��£���"$d���}[���t���U~�MQԲ�$��~��c��S�M�a���ш=��diH��(N�+U�D����f"V�"�����.ƈ�#Ͼ�eH:�x��d!k 6�J�f9�GW�4����Kp��T��3��~��G�؀��,�zZ��澰؋7����v#� &�r+O�@Ud7͐�$�\�D�O��W_�Ew�ͻ�7��oD����y��,��Ƣ�cƙd	���U�u�:�#�h6]�R
�U~	V�՟R�V������/�:r�F¬�k?|Ī�r\�<.�^9����?��]Aʻ�iT;vg�PpyM���1��},�dY\e8��I��2�wjM��S/�p�1�\^�6$4�F��(:�\nۢ�2�}�Pm�X�'.����U�3��bq�nXK�i_BD�_H}�r;Y^�t�<���o��#gw��2q_�|�^�<��E�h���O�����R�-Ɖ���S�	!��z�1�+iH�1G���+<����~�;|�F�{�}v�;s�j�Q;�٩�;&f�}�������tL ���#��Ъ>;��z���?U˽�~������e��{K%��/:F�/<�n�2k�8�x��S-�5�`��ԗ�H�{���R�y�S�(w��ѥe
�	0���w�޻�U1��7V-Q�̶ꪸ�g�X��3V&�T[+)b����2���(���B��,��z����9���B`��!��o�ע(�W�RZ���m��%/V�&��|g��f��*[_��nn��M�M`�%��)��Z�K$�����F�� ��$r^�k�K,	u;w������X���;�L�eoI�6��y%����~����)���0"�zc�BH�<�kW�E\.�b��R>mٺ��<����͑Թ���a=2X���=/��_;	Ρ�e&o.����]��2!�嫈�"I������j�höR��͒\L�0�e������,)ýf�; ��E��0��<%�Q�Aø�x8�� �]eQL�;|���꼬z�W2
�H�z�_��
/K`J�O�O�Y�~j���>����d�v��%�ެ7�4{%��٥7Z��>����|��5^�\ױ���:��Z^;��U��s�)��#�|�.̡���R2��j����şBб���*cMvD�W^{�������m�D��0�,������#���?O����
����?z�{ȓ'�|����/�����/�����/�����/�����/�����/�����/�����/|� �7/4sc[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://cio24j5uraa6f"
path="res://.godot/imported/index.png-00c435162d66b7c774d33d678d20600c.ctex"
metadata={
"vram_texture": false
}
 �����4�(Q���2�// Hey this is Hei! This shader "fakes" a 3D-camera perspective on CanvasItems.
// License: MIT

shader_type canvas_item;

// Camera FOV
uniform float fov : hint_range(1, 179) = 90;
uniform bool cull_back = true;
uniform float y_rot : hint_range(-180, 180) = 0.0;
uniform float x_rot : hint_range(-180, 180) = 0.0;
// At 0, the image retains its size when unrotated.
// At 1, the image is resized so that it can do a full
// rotation without clipping inside its rect.
uniform float inset : hint_range(0, 1) = 0.0;
// Consider changing this to a uniform and changing it from code

varying flat vec2 o;
varying vec3 p;

// Creates rotation matrix
void vertex(){
	float sin_b = sin(y_rot / 180.0 * PI);
	float cos_b = cos(y_rot / 180.0 * PI);
	float sin_c = sin(x_rot / 180.0 * PI);
	float cos_c = cos(x_rot / 180.0 * PI);
	
	mat3 inv_rot_mat;
	inv_rot_mat[0][0] = cos_b;
	inv_rot_mat[0][1] = 0.0;
	inv_rot_mat[0][2] = -sin_b;
	
	inv_rot_mat[1][0] = sin_b * sin_c;
	inv_rot_mat[1][1] = cos_c;
	inv_rot_mat[1][2] = cos_b * sin_c;
	
	inv_rot_mat[2][0] = sin_b * cos_c;
	inv_rot_mat[2][1] = -sin_c;
	inv_rot_mat[2][2] = cos_b * cos_c;
	
	
	float t = tan(fov / 360.0 * PI);
	p = inv_rot_mat * vec3((UV - 0.5), 0.5 / t);
	float v = (0.5 / t) + 0.5;
	p.xy *= v * inv_rot_mat[2].z;
	o = v * inv_rot_mat[2].xy;

	VERTEX += (UV - 0.5) / TEXTURE_PIXEL_SIZE * t * (1.0 - inset);
}

void fragment(){
	if (cull_back && p.z <= 0.0) discard;
	vec2 uv = (p.xy / p.z).xy - o;
    COLOR = texture(TEXTURE, uv + 0.5);
	COLOR.a *= step(max(abs(uv.x), abs(uv.y)), 0.5);
}D(��shader_type canvas_item;

uniform vec4 color = vec4(1.0, 0.8, 0.0, 1.0);
uniform float width : hint_range(0, 10) = 2.0;
uniform int pattern : hint_range(0, 2) = 0; // diamond, circle, square
uniform bool inside = false;
uniform bool add_margins = true; // only useful when inside is false

void vertex() {
	if (add_margins) {
		VERTEX += (UV * 2.0 - 1.0) * width;
	}
}

bool hasContraryNeighbour(vec2 uv, vec2 texture_pixel_size, sampler2D texture) {
	for (float i = -ceil(width); i <= ceil(width); i++) {
		float x = abs(i) > width ? width * sign(i) : i;
		float offset;
		
		if (pattern == 0) {
			offset = width - abs(x);
		} else if (pattern == 1) {
			offset = floor(sqrt(pow(width + 0.5, 2) - x * x));
		} else if (pattern == 2) {
			offset = width;
		}
		
		for (float j = -ceil(offset); j <= ceil(offset); j++) {
			float y = abs(j) > offset ? offset * sign(j) : j;
			vec2 xy = uv + texture_pixel_size * vec2(x, y);
			
			if ((xy != clamp(xy, vec2(0.0), vec2(1.0)) || texture(texture, xy).a == 0.0) == inside) {
				return true;
			}
		}
	}
	
	return false;
}

void fragment() {
	vec2 uv = UV;
	
	if (add_margins) {
		vec2 texture_pixel_size = vec2(1.0) / (vec2(1.0) / TEXTURE_PIXEL_SIZE + vec2(width * 2.0));
		
		uv = (uv - texture_pixel_size * width) * TEXTURE_PIXEL_SIZE / texture_pixel_size;
		
		if (uv != clamp(uv, vec2(0.0), vec2(1.0))) {
			COLOR.a = 0.0;
		} else {
			COLOR = texture(TEXTURE, uv);
		}
	} else {
		COLOR = texture(TEXTURE, uv);
	}
	
	if ((COLOR.a > 0.0) == inside && hasContraryNeighbour(uv, TEXTURE_PIXEL_SIZE, TEXTURE)) {
		COLOR.rgb = inside ? mix(COLOR.rgb, color.rgb, color.a) : color.rgb;
		COLOR.a += (1.0 - COLOR.a) * color.a;
	}
}D�(�GST2      `      ����                `          RIFF  WEBPVP8L
  /�G@@���!��:d&!�H.�O`�?@���J
�I�#B|׷�\նSG� ���X��Z���M�	�1����;r�6����n��8��	�����+�ρ�C���g�=|N�E��(J���;�z\ʭ� ��-���)�{p�K�G+|D,�wu���I���Վ5^=��:Xa}	���=L�0ڀ��k�C:�c��m�]��S���_�#c�h�Q���a4)"r�4q6r RCJ?�ُ��I�T����t�%)����9�GԽ�u_=��>.��V\����/�c���{����e~*=��)���x�^E|���=���s�-ބ̧��t�~GS�K����y��y6�r.J�{��h��������~;���y�c�BϾ�VJY_����&�o@֜k��>�c��m�]��S���_�#c�y�Q��y�#�xR��(k���|�H+�0f?�z�'YJQ���N�=�����l�c�~Dݫ�Q�e�c���on���ؿ�e{���v����/գ�O���-oL��+��[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://duu3rvl17joql"
path="res://.godot/imported/chess_pieces.png-218667da82b136a50484db49ffe6691d.ctex"
metadata={
"vram_texture": false
}
 ��9>�GST2              ����                          4   RIFF,   WEBPVP8L   /� 0��?��x$�[n�BD�3�8� ����[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://dlgwl46o3x1r2"
path="res://.godot/imported/chess_table.png-4167b35c68ab2328d903784b8e628f9d.ctex"
metadata={
"vram_texture": false
}
 5q!�bZgGST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /������!"2�H�$�n윦���z�x����դ�<����q����F��Z��?&,
ScI_L �;����In#Y��0�p~��Z��m[��N����R,��#"� )���d��mG�������ڶ�$�ʹ���۶�=���mϬm۶mc�9��z��T��7�m+�}�����v��ح�m�m������$$P�����එ#���=�]��SnA�VhE��*JG�
&����^x��&�+���2ε�L2�@��		��S�2A�/E���d"?���Dh�+Z�@:�Gk�FbWd�\�C�Ӷg�g�k��Vo��<c{��4�;M�,5��ٜ2�Ζ�yO�S����qZ0��s���r?I��ѷE{�4�Ζ�i� xK�U��F�Z�y�SL�)���旵�V[�-�1Z�-�1���z�Q�>�tH�0��:[RGň6�=KVv�X�6�L;�N\���J���/0u���_��U��]���ǫ)�9��������!�&�?W�VfY�2���༏��2kSi����1!��z+�F�j=�R�O�{�
ۇ�P-�������\����y;�[ ���lm�F2K�ޱ|��S��d)é�r�BTZ)e�� ��֩A�2�����X�X'�e1߬���p��-�-f�E�ˊU	^�����T�ZT�m�*a|	׫�:V���G�r+�/�T��@U�N׼�h�+	*�*sN1e�,e���nbJL<����"g=O��AL�WO!��߈Q���,ɉ'���lzJ���Q����t��9�F���A��g�B-����G�f|��x��5�'+��O��y��������F��2�����R�q�):VtI���/ʎ�UfěĲr'�g�g����5�t�ۛ�F���S�j1p�)�JD̻�ZR���Pq�r/jt�/sO�C�u����i�y�K�(Q��7őA�2���R�ͥ+lgzJ~��,eA��.���k�eQ�,l'Ɨ�2�,eaS��S�ԟe)��x��ood�d)����h��ZZ��`z�պ��;�Cr�rpi&��՜�Pf��+���:w��b�DUeZ��ڡ��iA>IN>���܋�b�O<�A���)�R�4��8+��k�Jpey��.���7ryc�!��M�a���v_��/�����'��t5`=��~	`�����p\�u����*>:|ٻ@�G�����wƝ�����K5�NZal������LH�]I'�^���+@q(�q2q+�g�}�o�����S߈:�R�݉C������?�1�.��
�ڈL�Fb%ħA ����Q���2�͍J]_�� A��Fb�����ݏ�4o��'2��F�  ڹ���W�L |����YK5�-�E�n�K�|�ɭvD=��p!V3gS��`�p|r�l	F�4�1{�V'&����|pj� ߫'ş�pdT�7`&�
�1g�����@D�˅ �x?)~83+	p �3W�w��j"�� '�J��CM�+ �Ĝ��"���4� ����nΟ	�0C���q'�&5.��z@�S1l5Z��]�~L�L"�"�VS��8w.����H�B|���K(�}
r%Vk$f�����8�ڹ���R�dϝx/@�_�k'�8���E���r��D���K�z3�^���Vw��ZEl%~�Vc���R� �Xk[�3��B��Ğ�Y��A`_��fa��D{������ @ ��dg�������Mƚ�R�`���s����>x=�����	`��s���H���/ū�R�U�g�r���/����n�;�SSup`�S��6��u���⟦;Z�AN3�|�oh�9f�Pg�����^��g�t����x��)Oq�Q�My55jF����t9����,�z�Z�����2��#�)���"�u���}'�*�>�����ǯ[����82һ�n���0�<v�ݑa}.+n��'����W:4TY�����P�ר���Cȫۿ�Ϗ��?����Ӣ�K�|y�@suyo�<�����{��x}~�����~�AN]�q�9ޝ�GG�����[�L}~�`�f%4�R!1�no���������v!�G����Qw��m���"F!9�vٿü�|j�����*��{Ew[Á��������u.+�<���awͮ�ӓ�Q �:�Vd�5*��p�ioaE��,�LjP��	a�/�˰!{g:���3`=`]�2��y`�"��N�N�p���� ��3�Z��䏔��9"�ʞ l�zP�G�ߙj��V�>���n�/��׷�G��[���\��T��Ͷh���ag?1��O��6{s{����!�1�Y�����91Qry��=����y=�ٮh;�����[�tDV5�chȃ��v�G ��T/'XX���~Q�7��+[�e��Ti@j��)��9��J�hJV�#�jk�A�1�^6���=<ԧg�B�*o�߯.��/�>W[M���I�o?V���s��|yu�xt��]�].��Yyx�w���`��C���pH��tu�w�J��#Ef�Y݆v�f5�e��8��=�٢�e��W��M9J�u�}]釧7k���:�o�����Ç����ս�r3W���7k���e�������ϛk��Ϳ�_��lu�۹�g�w��~�ߗ�/��ݩ�-�->�I�͒���A�	���ߥζ,�}�3�UbY?�Ӓ�7q�Db����>~8�]
� ^n׹�[�o���Z-�ǫ�N;U���E4=eȢ�vk��Z�Y�j���k�j1�/eȢK��J�9|�,UX65]W����lQ-�"`�C�.~8ek�{Xy���d��<��Gf�ō�E�Ӗ�T� �g��Y�*��.͊e��"�]�d������h��ڠ����c�qV�ǷN��6�z���kD�6�L;�N\���Y�����
�O�ʨ1*]a�SN�=	fH�JN�9%'�S<C:��:`�s��~��jKEU�#i����$�K�TQD���G0H�=�� �d�-Q�H�4�5��L�r?����}��B+��,Q�yO�H�jD�4d�����0*�]�	~�ӎ�.�"����%
��d$"5zxA:�U��H���H%jس{���kW��)�	8J��v�}�rK�F�@�t)FXu����G'.X�8�KH;���[ �JI�p���H�[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://d33mhofsxjken"
path="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex"
metadata={
"vram_texture": false
}
 �X#�c�P�H�U0��[remap]

path="res://.godot/exported/133200997/export-ff5329f87f2609f6a6262b03d8c5d3d2-chess_piece.scn"
��f��"P[remap]

path="res://.godot/exported/133200997/export-0aaa2c84e4a2f194841ec83e14db9ed9-chess_table.scn"
��1�H�>�[remap]

path="res://.godot/exported/133200997/export-b25f410ac0d91cdecf41dcbf483f032f-node.scn"
�8̽�-S�W��GL[remap]

path="res://.godot/exported/133200997/export-d0f61513d6cd1d62dc97be967a767129-tile_map.scn"
D��ÀVAS�[remap]

path="res://.godot/exported/133200997/export-8a4be96665b612e7674338382922fd94-chess_move_area.scn"
��b[remap]

path="res://.godot/exported/133200997/export-0decd75b32a47a22134ebcf9642c246a-move_manager.scn"
�h�kId9list=Array[Dictionary]([{
"base": &"Node2D",
"class": &"ChessPiece",
"icon": "",
"language": &"GDScript",
"path": "res://chess_pieces/chess_piece.gd"
}, {
"base": &"Node2D",
"class": &"ChessTable",
"icon": "",
"language": &"GDScript",
"path": "res://chess_table/chess_table.gd"
}, {
"base": &"Node",
"class": &"MoveManager",
"icon": "",
"language": &"GDScript",
"path": "res://controllers/move_manager.gd"
}, {
"base": &"Node",
"class": &"TYPE",
"icon": "",
"language": &"GDScript",
"path": "res://DataTypes/TYPE.gd"
}])
+���8�<svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><rect x="2" y="2" width="124" height="124" rx="14" fill="#363d52" stroke="#212532" stroke-width="4"/><g transform="scale(.101) translate(122 122)"><g fill="#fff"><path d="M105 673v33q407 354 814 0v-33z"/><path fill="#478cbf" d="m105 673 152 14q12 1 15 14l4 67 132 10 8-61q2-11 15-15h162q13 4 15 15l8 61 132-10 4-67q3-13 15-14l152-14V427q30-39 56-81-35-59-83-108-43 20-82 47-40-37-88-64 7-51 8-102-59-28-123-42-26 43-46 89-49-7-98 0-20-46-46-89-64 14-123 42 1 51 8 102-48 27-88 64-39-27-82-47-48 49-83 108 26 42 56 81zm0 33v39c0 276 813 276 813 0v-39l-134 12-5 69q-2 10-14 13l-162 11q-12 0-16-11l-10-65H447l-10 65q-4 11-16 11l-162-11q-12-3-14-13l-5-69z"/><path d="M483 600c3 34 55 34 58 0v-86c-3-34-55-34-58 0z"/><circle cx="725" cy="526" r="90"/><circle cx="299" cy="526" r="90"/></g><g fill="#414042"><circle cx="307" cy="532" r="60"/><circle cx="717" cy="532" r="60"/></g></g></svg>
2hA�a�Ũ�   �!���n�#   res://chess_pieces/chess_piece.tscn,�xd`    res://chess_pieces/move-self.mp3�����"   res://chess_table/chess_table.tscn���P�d#   res://controllers/move_manager.tscn-�.-W�t-   res://releases/web/index.apple-touch-icon.pngnCm�zL!   res://releases/web/index.icon.png	�UĬ�!   res://releases/web/index.png��(z/�nw   res://textures/chess_pieces.png��{���Bn   res://textures/chess_table.pngu�ͫm�p   res://icon.svgu)�z	:h!   res://releases/web/index.icon.pngC��d�nKe-   res://releases/web/index.apple-touch-icon.png��?tJ   res://releases/web/index.png�}��: :   res://chess_table/node.tscn)Ř�T��&   res://chess_table/chess_move_area.tscn)Ř�T��&   res://controllers/chess_move_area.tscn)���*;   res://tile_map.tscnsn}Uc+   res://chess_table/tile_map.tscn��c�ECFG      application/config/name      	   RPG Chess      application/run/main_scene,      "   res://chess_table/chess_table.tscn     application/config/features$   "         4.1    Forward Plus       application/config/icon         res://icon.svg     display/window/stretch/mode         viewport   input/left_click�              events              InputEventMouseButton         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          button_mask           position              global_position               factor       �?   button_index         canceled          pressed           double_click          script            deadzone      ?9   rendering/textures/canvas_textures/default_texture_filter          4   rendering/textures/vram_compression/import_etc2_astc         L��i*�y�