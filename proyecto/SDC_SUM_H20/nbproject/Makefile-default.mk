#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Include project Makefile
ifeq "${IGNORE_LOCAL}" "TRUE"
# do not include local makefile. User is passing all local related variables already
else
include Makefile
# Include makefile containing local settings
ifeq "$(wildcard nbproject/Makefile-local-default.mk)" "nbproject/Makefile-local-default.mk"
include nbproject/Makefile-local-default.mk
endif
endif

# Environment
MKDIR=gnumkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=default
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
OUTPUT_SUFFIX=cof
DEBUGGABLE_SUFFIX=cof
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/SDC_SUM_H20.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=cof
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/SDC_SUM_H20.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
endif

ifeq ($(COMPARE_BUILD), true)
COMPARISON_BUILD=
else
COMPARISON_BUILD=
endif

ifdef SUB_IMAGE_ADDRESS

else
SUB_IMAGE_ADDRESS_COMMAND=
endif

# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}

# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Source Files Quoted if spaced
SOURCEFILES_QUOTED_IF_SPACED=../proyecto/cisterna.asm ../proyecto/Tinaco.asm

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/_ext/1540928396/cisterna.o ${OBJECTDIR}/_ext/1540928396/Tinaco.o
POSSIBLE_DEPFILES=${OBJECTDIR}/_ext/1540928396/cisterna.o.d ${OBJECTDIR}/_ext/1540928396/Tinaco.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/_ext/1540928396/cisterna.o ${OBJECTDIR}/_ext/1540928396/Tinaco.o

# Source Files
SOURCEFILES=../proyecto/cisterna.asm ../proyecto/Tinaco.asm



CFLAGS=
ASFLAGS=
LDLIBSOPTIONS=

############# Tool locations ##########################################
# If you copy a project from one host to another, the path where the  #
# compiler is installed may be different.                             #
# If you open this project with MPLAB X in the new host, this         #
# makefile will be regenerated and the paths will be corrected.       #
#######################################################################
# fixDeps replaces a bunch of sed/cat/printf statements that slow down the build
FIXDEPS=fixDeps

.build-conf:  ${BUILD_SUBPROJECTS}
ifneq ($(INFORMATION_MESSAGE), )
	@echo $(INFORMATION_MESSAGE)
endif
	${MAKE}  -f nbproject/Makefile-default.mk dist/${CND_CONF}/${IMAGE_TYPE}/SDC_SUM_H20.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

MP_PROCESSOR_OPTION=16f877a
MP_LINKER_DEBUG_OPTION= 
# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/_ext/1540928396/cisterna.o: ../proyecto/cisterna.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1540928396" 
	@${RM} ${OBJECTDIR}/_ext/1540928396/cisterna.o.d 
	@${RM} ${OBJECTDIR}/_ext/1540928396/cisterna.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/_ext/1540928396/cisterna.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_SIMULATOR=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/_ext/1540928396/cisterna.lst\" -e\"${OBJECTDIR}/_ext/1540928396/cisterna.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/_ext/1540928396/cisterna.o\" \"../proyecto/cisterna.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/_ext/1540928396/cisterna.o"
	@${FIXDEPS} "${OBJECTDIR}/_ext/1540928396/cisterna.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/_ext/1540928396/Tinaco.o: ../proyecto/Tinaco.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1540928396" 
	@${RM} ${OBJECTDIR}/_ext/1540928396/Tinaco.o.d 
	@${RM} ${OBJECTDIR}/_ext/1540928396/Tinaco.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/_ext/1540928396/Tinaco.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_SIMULATOR=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/_ext/1540928396/Tinaco.lst\" -e\"${OBJECTDIR}/_ext/1540928396/Tinaco.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/_ext/1540928396/Tinaco.o\" \"../proyecto/Tinaco.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/_ext/1540928396/Tinaco.o"
	@${FIXDEPS} "${OBJECTDIR}/_ext/1540928396/Tinaco.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
else
${OBJECTDIR}/_ext/1540928396/cisterna.o: ../proyecto/cisterna.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1540928396" 
	@${RM} ${OBJECTDIR}/_ext/1540928396/cisterna.o.d 
	@${RM} ${OBJECTDIR}/_ext/1540928396/cisterna.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/_ext/1540928396/cisterna.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/_ext/1540928396/cisterna.lst\" -e\"${OBJECTDIR}/_ext/1540928396/cisterna.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/_ext/1540928396/cisterna.o\" \"../proyecto/cisterna.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/_ext/1540928396/cisterna.o"
	@${FIXDEPS} "${OBJECTDIR}/_ext/1540928396/cisterna.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/_ext/1540928396/Tinaco.o: ../proyecto/Tinaco.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1540928396" 
	@${RM} ${OBJECTDIR}/_ext/1540928396/Tinaco.o.d 
	@${RM} ${OBJECTDIR}/_ext/1540928396/Tinaco.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/_ext/1540928396/Tinaco.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/_ext/1540928396/Tinaco.lst\" -e\"${OBJECTDIR}/_ext/1540928396/Tinaco.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/_ext/1540928396/Tinaco.o\" \"../proyecto/Tinaco.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/_ext/1540928396/Tinaco.o"
	@${FIXDEPS} "${OBJECTDIR}/_ext/1540928396/Tinaco.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
dist/${CND_CONF}/${IMAGE_TYPE}/SDC_SUM_H20.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_LD} $(MP_EXTRA_LD_PRE)   -p$(MP_PROCESSOR_OPTION)  -w -x -u_DEBUG -z__ICD2RAM=1 -m"${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map"   -z__MPLAB_BUILD=1  -z__MPLAB_DEBUG=1 -z__MPLAB_DEBUGGER_SIMULATOR=1 $(MP_LINKER_DEBUG_OPTION) -odist/${CND_CONF}/${IMAGE_TYPE}/SDC_SUM_H20.${IMAGE_TYPE}.${OUTPUT_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}     
else
dist/${CND_CONF}/${IMAGE_TYPE}/SDC_SUM_H20.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_LD} $(MP_EXTRA_LD_PRE)   -p$(MP_PROCESSOR_OPTION)  -w  -m"${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map"   -z__MPLAB_BUILD=1  -odist/${CND_CONF}/${IMAGE_TYPE}/SDC_SUM_H20.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}     
endif


# Subprojects
.build-subprojects:


# Subprojects
.clean-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r build/default
	${RM} -r dist/default

# Enable dependency checking
.dep.inc: .depcheck-impl

DEPFILES=$(shell mplabwildcard ${POSSIBLE_DEPFILES})
ifneq (${DEPFILES},)
include ${DEPFILES}
endif
