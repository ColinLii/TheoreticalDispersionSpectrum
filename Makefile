vpath %.f src
vpath %.F src
vpath %.f90 src
vpath %.o OBJ

OBJS = MainProgram.o  comvar.o  Gbasic.o Ginput.o Grtcoefs.o \
	Gsubs.o  integrang_calc.o MTX_SUB.o SOURCE.o UKO.o Ydumtx.o

OBJ_PATH = OBJ
SRC_PATH = src
BIN_PATH = bin
FC=ifort

$(BIN_PATH)/MainProgram : $(OBJS)
	$(FC) $^ -o $@

$(OBJ_PATH)/MainProgram.o : MainProgram.f
	$(FC) -c $< -o $@

$(OBJ_PATH)/comvar.o : comvar.f90
	$(FC) -c $< -o $@

$(OBJ_PATH)/Gbasic.o : Gbasic.F
	$(FC) -c $< -o $@

$(OBJ_PATH)/Ginput.o : Ginput.F
	$(FC) -c $< -o $@

$(OBJ_PATH)/Grtcoefs.o : Grtcoefs.F
	$(FC) -c $< -o $@

$(OBJ_PATH)/Gsubs.o : Gsubs.f
	$(FC) -c $< -o $@

$(OBJ_PATH)/integrang_calc.o : integrang_calc.f90
	$(FC) -c $< -o $@

$(OBJ_PATH)/MTX_SUB.o : MTX_SUB.F
	$(FC) -c $< -o $@

$(OBJ_PATH)/SOURCE.o : SOURCE.F
	$(FC) -c $< -o $@

$(OBJ_PATH)/UKO.o : UKO.F
	$(FC) -c $< -o $@

$(OBJ_PATH)/Ydumtx.o  : Ydumtx.f
	$(FC) -c $< -o $@
