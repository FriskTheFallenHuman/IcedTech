# CMakeList.txt : CMake project for IcedTech, include source and define
# project specific logic here.
#
cmake_minimum_required (VERSION 3.8.0...3.20)

project(IcedTech)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

OPTION(ID_ALLOW_TOOLS "Compile Tools" ON)
OPTION(ID_UNICODE "Use unicode version of WIN32 API" OFF)
OPTION(ID_ENFORCE32BIT "Build 32bit on 64bit linux platform" ON)

include(CompilationSettings.cmake)

# Check to see if we are wanting a SDK project or a full engine project
Message("${CMAKE_CURRENT_SOURCE_DIR}/full_sdk_license.txt")

# idLib files
set(src_idlib
	./idlib/precompiled.h
	./idlib/Base64.cpp
	./idlib/BitMsg.h
	./idlib/Base64.h
	./idlib/BitMsg.cpp
	./idlib/CmdArgs.cpp
	./idlib/CmdArgs.h
	./idlib/Dict.cpp
	./idlib/Dict.h
	./idlib/Heap.cpp
	./idlib/Heap.h
	./idlib/LangDict.cpp
	./idlib/LangDict.h
	./idlib/Lexer.cpp
	./idlib/Lexer.h
	./idlib/Lib.cpp
	./idlib/Lib.h
	./idlib/MapFile.cpp
	./idlib/MapFile.h
	./idlib/Parser.cpp
	./idlib/Parser.h
	./idlib/Str.cpp
	./idlib/Str.h
	./idlib/Swap.h
	./idlib/Timer.cpp
	./idlib/Timer.h
	./idlib/Token.cpp
	./idlib/Token.h
	./idlib/bv/Bounds.cpp
	./idlib/bv/Bounds.h
	./idlib/bv/Box.cpp
	./idlib/bv/Box.h
	./idlib/bv/Frustum.cpp
	./idlib/bv/Frustum.h
	./idlib/bv/Sphere.cpp
	./idlib/bv/Sphere.h
	./idlib/containers/Array.h
	./idlib/containers/BinSearch.h
	./idlib/containers/BTree.h
	./idlib/containers/HashIndex.cpp
	./idlib/containers/HashIndex.h
	./idlib/containers/HashTable.h
	./idlib/containers/Hierarchy.h
	./idlib/containers/LinkList.h
	./idlib/containers/List.h
	./idlib/containers/ListSTL.h
	./idlib/containers/PlaneSet.h
	./idlib/containers/Queue.h
	./idlib/containers/Sort.h
	./idlib/containers/Stack.h
	./idlib/containers/StaticList.h
	./idlib/containers/StrList.h
	./idlib/containers/StrPool.h
	./idlib/containers/VectorSet.h
	./idlib/geometry/DrawVert.cpp
	./idlib/geometry/DrawVert.h
	./idlib/geometry/JointTransform.cpp
	./idlib/geometry/JointTransform.h
	./idlib/geometry/Surface.cpp
	./idlib/geometry/Surface.h
	./idlib/geometry/Surface_Patch.cpp
	./idlib/geometry/Surface_Patch.h
	./idlib/geometry/Surface_Polytope.cpp
	./idlib/geometry/Surface_Polytope.h
	./idlib/geometry/Surface_SweptSpline.cpp
	./idlib/geometry/Surface_SweptSpline.h
	./idlib/geometry/TraceModel.cpp
	./idlib/geometry/TraceModel.h
	./idlib/geometry/Winding.cpp
	./idlib/geometry/Winding.h
	./idlib/geometry/Winding2D.cpp
	./idlib/geometry/Winding2D.h
	./idlib/hashing/CRC32.cpp
	./idlib/hashing/CRC32.h
	./idlib/hashing/MD4.cpp
	./idlib/hashing/MD4.h
	./idlib/hashing/MD5.cpp
	./idlib/hashing/MD5.h
	./idlib/math/Angles.cpp
	./idlib/math/Angles.h
	./idlib/math/Complex.cpp
	./idlib/math/Complex.h
	./idlib/math/Curve.h
	./idlib/math/Extrapolate.h
	./idlib/math/Float16.h
	./idlib/math/Interpolate.h
	./idlib/math/Lcp.cpp
	./idlib/math/Lcp.h
	./idlib/math/Math.cpp
	./idlib/math/Math.h
	./idlib/math/Matrix.cpp
	./idlib/math/Matrix.h
	./idlib/math/Ode.cpp
	./idlib/math/Ode.h
	./idlib/math/Plane.cpp
	./idlib/math/Plane.h
	./idlib/math/Pluecker.cpp
	./idlib/math/Pluecker.h
	./idlib/math/Polynomial.cpp
	./idlib/math/Polynomial.h
	./idlib/math/Quat.cpp
	./idlib/math/Quat.h
	./idlib/math/Random.h
	./idlib/math/Rotation.cpp
	./idlib/math/Rotation.h
	./idlib/math/Simd.cpp
	./idlib/math/Simd.h
	./idlib/math/Simd_3DNow.cpp
	./idlib/math/Simd_3DNow.h
	./idlib/math/Simd_Generic.cpp
	./idlib/math/Simd_Generic.h
	./idlib/math/Simd_MMX.cpp
	./idlib/math/Simd_MMX.h
	./idlib/math/Simd_SSE.cpp
	./idlib/math/Simd_SSE.h
	./idlib/math/Simd_SSE2.cpp
	./idlib/math/Simd_SSE2.h
	./idlib/math/Simd_SSE3.cpp
	./idlib/math/Simd_SSE3.h
	./idlib/math/Vector.cpp
	./idlib/math/Vector.h
)

source_group(idlib ./idlib/.*)  
source_group(idlib\\BV ./idlib/bv/.*)  
source_group(idlib\\Containers ./idlib/containers/.*)  
source_group(idlib\\Geometry ./idlib/geometry/.*)  
source_group(idlib\\Hashing ./idlib/hashing/.*)  
source_group(idlib\\Math ./idlib/math/.*) 

set(src_game
	./game/Actor.cpp
	./game/Actor.h
	./game/AF.cpp
	./game/AF.h
	./game/AFEntity.cpp
	./game/AFEntity.h
	./game/BrittleFracture.cpp
	./game/BrittleFracture.h
	./game/Camera.cpp
	./game/Camera.h
	./game/Entity.cpp
	./game/Entity.h
	./game/Fx.cpp
	./game/Fx.h
	./game/Game.def
	./game/Game.h
	./game/GameEdit.cpp
	./game/GameEdit.h
	./game/Game_local.cpp
	./game/Game_local.h
	./game/Game_network.cpp
	./game/Game_parallel.cpp
	./game/Game_render.cpp
	./game/IK.cpp
	./game/IK.h
	./game/Item.cpp
	./game/Item.h
	./game/Light.cpp
	./game/Light.h
	./game/Misc.cpp
	./game/Misc.h
	./game/Moveable.cpp
	./game/Moveable.h
	./game/Mover.cpp
	./game/Mover.h
	./game/MultiplayerGame.cpp
	./game/MultiplayerGame.h
	./game/Player.cpp
	./game/Player.h
	./game/PlayerIcon.cpp
	./game/PlayerIcon.h
	./game/PlayerView.cpp
	./game/PlayerView.h
	./game/Projectile.cpp
	./game/Projectile.h
	./game/Pvs.cpp
	./game/Pvs.h
	./game/SecurityCamera.cpp
	./game/SecurityCamera.h
	./game/SmokeParticles.cpp
	./game/SmokeParticles.h
	./game/Sound.cpp
	./game/Sound.h
	./game/Target.cpp
	./game/Target.h
	./game/Trigger.cpp
	./game/Trigger.h
	./game/Weapon.cpp
	./game/Weapon.h
	./game/WorldSpawn.cpp
	./game/WorldSpawn.h
	./game/ai/AAS.cpp
	./game/ai/AAS.h
	./game/ai/AAS_debug.cpp
	./game/ai/AAS_local.h
	./game/ai/AAS_pathing.cpp
	./game/ai/AAS_routing.cpp
	./game/ai/AI.cpp
	./game/ai/AI.h
	./game/ai/AI_events.cpp
	./game/ai/AI_pathing.cpp
	./game/ai/AI_Vagary.cpp
	./game/anim/Anim.cpp
	./game/anim/Anim.h
	./game/anim/Anim_Blend.cpp
	./game/anim/Anim_Import.cpp
	./game/anim/Anim_Testmodel.cpp
	./game/anim/Anim_Testmodel.h
	./game/gamesys/Class.cpp
	./game/gamesys/Class.h
	./game/gamesys/DebugGraph.cpp
	./game/gamesys/DebugGraph.h
	./game/gamesys/Event.cpp
	./game/gamesys/Event.h
	./game/gamesys/NoGameTypeInfo.h
	./game/gamesys/SaveGame.cpp
	./game/gamesys/SaveGame.h
	./game/gamesys/SysCmds.cpp
	./game/gamesys/SysCmds.h
	./game/gamesys/SysCvar.cpp
	./game/gamesys/SysCvar.h
	./game/physics/Clip.cpp
	./game/physics/Clip.h
	./game/physics/Force.cpp
	./game/physics/Force.h
	./game/physics/Force_Constant.cpp
	./game/physics/Force_Constant.h
	./game/physics/Force_Drag.cpp
	./game/physics/Force_Drag.h
	./game/physics/Force_Field.cpp
	./game/physics/Force_Field.h
	./game/physics/Force_Spring.cpp
	./game/physics/Force_Spring.h
	./game/physics/Physics.cpp
	./game/physics/Physics.h
	./game/physics/Physics_Actor.cpp
	./game/physics/Physics_Actor.h
	./game/physics/Physics_AF.cpp
	./game/physics/Physics_AF.h
	./game/physics/Physics_Base.cpp
	./game/physics/Physics_Base.h
	./game/physics/Physics_Monster.cpp
	./game/physics/Physics_Monster.h
	./game/physics/Physics_Parametric.cpp
	./game/physics/Physics_Parametric.h
	./game/physics/Physics_Player.cpp
	./game/physics/Physics_Player.h
	./game/physics/Physics_RigidBody.cpp
	./game/physics/Physics_RigidBody.h
	./game/physics/Physics_Static.cpp
	./game/physics/Physics_Static.h
	./game/physics/Physics_StaticMulti.cpp
	./game/physics/Physics_StaticMulti.h
	./game/physics/Push.cpp
	./game/physics/Push.h
	./game/script/Script_Compiler.cpp
	./game/script/Script_Compiler.h
	./game/script/Script_Interpreter.cpp
	./game/script/Script_Interpreter.h
	./game/script/Script_Program.cpp
	./game/script/Script_Program.h
	./game/script/Script_Thread.cpp
	./game/script/Script_Thread.h
)

source_group(game ./game/.*)  
source_group(game\\AI ./game/ai/.*)  
source_group(game\\Animation ./game/anim/.*)  
source_group(game\\GameSys ./game/gamesys/.*)  
source_group(game\\Physics ./game/physics/.*)  
source_group(game\\Script ./game/script/.*) 

# Engine Directories
include_directories(./idlib)

# idLib project
add_library(idlib ${src_idlib})
target_precompile_headers(idlib PRIVATE ./idlib/precompiled.h)
set_property(TARGET idlib PROPERTY FOLDER libs)
set_cpu_arch(idlib)

# Game Project
if(CMAKE_SIZEOF_VOID_P EQUAL 8 AND NOT ID_ENFORCE32BIT)
	set(TARGET_NAME "gamex64")
else()
	set(TARGET_NAME "gamex86")
endif()

add_library(${TARGET_NAME} SHARED ${src_game})
target_link_libraries(${TARGET_NAME} idlib)
target_compile_definitions(${TARGET_NAME} PRIVATE GAME_DLL)
target_precompile_headers(${TARGET_NAME} PRIVATE ./idlib/precompiled.h)
set_property(TARGET ${TARGET_NAME} PROPERTY FOLDER dlls) 
set_cpu_arch(${TARGET_NAME}) 

if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/full_sdk_license.txt")
	if(ID_ALLOW_TOOLS)
		Message("Including Tools...")
		include( Tools.cmake )
	endif()

	Message("Including Engine...")
	include( IcedTech.cmake )
else()
	Message("Generated SDK projects...")
endif()
