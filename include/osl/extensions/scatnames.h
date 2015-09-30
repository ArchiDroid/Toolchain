
    /*+-----------------------------------------------------------------**
     **                       OpenScop Library                          **
     **-----------------------------------------------------------------**
     **                    extensions/scatnames.h                       **
     **-----------------------------------------------------------------**
     **                   First version: 03/12/2011                     **
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


#ifndef OSL_SCATNAMES_H
# define OSL_SCATNAMES_H

# include <stdio.h>
# include <osl/interface.h>
# include <osl/strings.h>

# if defined(__cplusplus)
extern "C"
  {
# endif


# define OSL_URI_SCATNAMES        "scatnames"


/**
 * The osl_scatnames_t structure stores a scatnames extention to the core
 * OpenScop representation. It is devoted to store the scattering dimension
 * names in a textual form. The names are stored using an osl_strings_t
 * structure and their order in the array corresponds to their dimension
 * order.
 */
struct osl_scatnames {
  osl_strings_p names;  /**< List of textual scattering dimension names. */
};
typedef struct osl_scatnames   osl_scatnames_t;
typedef struct osl_scatnames * osl_scatnames_p;


/*+***************************************************************************
 *                          Structure display function                       *
 *****************************************************************************/
void            osl_scatnames_idump(FILE *, osl_scatnames_p, int);
void            osl_scatnames_dump(FILE *, osl_scatnames_p);
char *          osl_scatnames_sprint(osl_scatnames_p);


/*****************************************************************************
 *                               Reading function                            *
 *****************************************************************************/
osl_scatnames_p osl_scatnames_sread(char **);


/*+***************************************************************************
 *                    Memory allocation/deallocation function                *
 *****************************************************************************/
osl_scatnames_p osl_scatnames_malloc();
void            osl_scatnames_free(osl_scatnames_p);


/*+***************************************************************************
 *                            Processing functions                           *
 *****************************************************************************/
osl_scatnames_p osl_scatnames_clone(osl_scatnames_p);
int             osl_scatnames_equal(osl_scatnames_p, osl_scatnames_p);
osl_interface_p osl_scatnames_interface();


# if defined(__cplusplus)
  }
# endif

#endif /* define OSL_SCATNAMES_H */
