
    /*+-----------------------------------------------------------------**
     **                       OpenScop Library                          **
     **-----------------------------------------------------------------**
     **                            scop.h                               **
     **-----------------------------------------------------------------**
     **                   First version: 30/04/2008                     **
     **-----------------------------------------------------------------**

 
 *****************************************************************************
 * OpenScop: Structures and formats for polyhedral tools to talk together    *
 *****************************************************************************
 *    ,___,,_,__,,__,,__,,__,,_,__,,_,__,,__,,___,_,__,,_,__,                *
 *    /   / /  //  //  //  // /   / /  //  //   / /  // /  /|,_,             *
 *   /   / /  //  //  //  // /   / /  //  //   / /  // /  / / /\             *
 *  |~~~|~|~~~|~~~|~~~|~~~|~|~~~|~|~~~|~~~|~~~|~|~~~|~|~~~|/_/  \            *
 *  | G |C| P | = | L | P |=| = |C| = | = | = |=| = |=| C |\  \ /\           *
 *  | R |l| o | = | e | l |=| = |a| = | = | = |=| = |=| L | \# \ /\          *
 *  | A |a| l | = | t | u |=| = |n| = | = | = |=| = |=| o | |\# \  \         *
 *  | P |n| l | = | s | t |=| = |d| = | = | = | |   |=| o | | \# \  \        *
 *  | H | | y |   | e | o | | = |l|   |   | = | |   | | G | |  \  \  \       *
 *  | I | |   |   | e |   | |   | |   |   |   | |   | |   | |   \  \  \      *
 *  | T | |   |   |   |   | |   | |   |   |   | |   | |   | |    \  \  \     *
 *  | E | |   |   |   |   | |   | |   |   |   | |   | |   | |     \  \  \    *
 *  | * |*| * | * | * | * |*| * |*| * | * | * |*| * |*| * | /      \* \  \   *
 *  | O |p| e | n | S | c |o| p |-| L | i | b |r| a |r| y |/        \  \ /   *
 *  '---'-'---'---'---'---'-'---'-'---'---'---'-'---'-'---'          '--'    *
 *                                                                           *
 * Copyright (C) 2008 University Paris-Sud 11 and INRIA                      *
 *                                                                           *
 * (3-clause BSD license)                                                    *
 * Redistribution and use in source  and binary forms, with or without       *
 * modification, are permitted provided that the following conditions        *
 * are met:                                                                  *
 *                                                                           *
 * 1. Redistributions of source code must retain the above copyright notice, *
 *    this list of conditions and the following disclaimer.                  *
 * 2. Redistributions in binary form must reproduce the above copyright      *
 *    notice, this list of conditions and the following disclaimer in the    *
 *    documentation and/or other materials provided with the distribution.   *
 * 3. The name of the author may not be used to endorse or promote products  *
 *    derived from this software without specific prior written permission.  *
 *                                                                           *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR      *
 * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES *
 * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.   *
 * IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,          *
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT  *
 * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, *
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY     *
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT       *
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF  *
 * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.         *
 *                                                                           *
 * OpenScop Library, a library to manipulate OpenScop formats and data       *
 * structures. Written by:                                                   *
 * Cedric Bastoul     <Cedric.Bastoul@u-psud.fr> and                         *
 * Louis-Noel Pouchet <Louis-Noel.pouchet@inria.fr>                          *
 *                                                                           *
 *****************************************************************************/


/*+****************************************************************************
 *  THIS FILE HAS BEEN AUTOMATICALLY GENERATED FROM scop.h.in BY configure    *
 ******************************************************************************/


#ifndef OSL_SCOP_H
# define OSL_SCOP_H

# include <unistd.h>

# define OSL_RELEASE "0.9.0"

# include <osl/relation.h>
# include <osl/interface.h>
# include <osl/generic.h>
# include <osl/statement.h>


# if defined(__cplusplus)
extern "C"
  {
# endif


/**
 * The scop_t structure stores a list of scops. Each node stores the useful
 * information of a static control part of a program to process it within a
 * polyhedral framework. Parameter information may be strings of characters
 * (char *) when the type field is OSL_TYPE_STRING or a generic pointer
 * to anything else (void *) when the type field is OSL_TYPE_GENERIC.
 * The OpenScop library does not touch AT ALL generic information: printing,
 * copy etc. must be done externally.
 */
struct osl_scop {
  int version;               /**< Version of the data structure */
  char * language;           /**< Target language (backend) */
  osl_relation_p context;    /**< Constraints on the SCoP parameters */
  osl_generic_p parameters;  /**< NULL-terminated array of parameters */
  osl_statement_p statement; /**< Statement list of the SCoP */
  osl_interface_p registry;  /**< Registered extensions interfaces */
  osl_generic_p extension;   /**< List of extensions */
  void * usr;                /**< A user-defined field, not touched
			          AT ALL by the OpenScop Library */
  struct osl_scop * next;    /**< Next statement in the linked list */
};
typedef struct osl_scop   osl_scop_t;
typedef struct osl_scop * osl_scop_p;


/*+***************************************************************************
 *                          Structure display function                       *
 *****************************************************************************/
void       osl_scop_idump(FILE *, osl_scop_p, int);
void       osl_scop_dump(FILE *, osl_scop_p);
void       osl_scop_print(FILE *, osl_scop_p);

// SCoPLib Compatibility
void       osl_scop_print_scoplib(FILE *, osl_scop_p);


/*****************************************************************************
 *                               Reading function                            *
 *****************************************************************************/
osl_scop_p osl_scop_pread(FILE *, osl_interface_p, int);
osl_scop_p osl_scop_read(FILE *);


/*+***************************************************************************
 *                    Memory allocation/deallocation function                *
 *****************************************************************************/
osl_scop_p osl_scop_malloc();
void       osl_scop_free(osl_scop_p);


/*+***************************************************************************
 *                            Processing functions                           *
 *****************************************************************************/
void       osl_scop_add(osl_scop_p *, osl_scop_p);
size_t     osl_scop_number(osl_scop_p);
osl_scop_p osl_scop_clone(osl_scop_p);
osl_scop_p osl_scop_remove_unions(osl_scop_p);
int        osl_scop_equal(osl_scop_p, osl_scop_p);
int        osl_scop_integrity_check(osl_scop_p);
int        osl_scop_check_compatible_scoplib(osl_scop_p);
int        osl_scop_get_nb_parameters(osl_scop_p);
void       osl_scop_register_extension(osl_scop_p, osl_interface_p);
void       osl_scop_get_attributes(osl_scop_p,
                                   int *, int *, int *, int *, int *);
void       osl_scop_normalize_scattering(osl_scop_p);

osl_names_p osl_scop_names(osl_scop_p scop);

# if defined(__cplusplus)
  }
# endif

#endif /* define OSL_SCOP_H */
