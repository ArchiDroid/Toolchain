/*
 * Output various information about GMP and MPFR.
 */

/*
Copyright 2010-2015 Free Software Foundation, Inc.
Contributed by the AriC and Caramel projects, INRIA.

This file is part of the GNU MPFR Library.

The GNU MPFR Library is free software; you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation; either version 3 of the License, or (at your
option) any later version.

The GNU MPFR Library is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public
License for more details.

You should have received a copy of the GNU Lesser General Public License
along with the GNU MPFR Library; see the file COPYING.LESSER.  If not, see
http://www.gnu.org/licenses/ or write to the Free Software Foundation, Inc.,
51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA.
*/

#include <stdio.h>
#include <limits.h>
#include <gmp.h>
#include <mpfr.h>

#define SIGNED_STR(V) ((V) < 0 ? "signed" : "unsigned")
#define SIGNED(I) SIGNED_STR((I) - (I) - 1)

/* The following failure can occur if GMP has been rebuilt with
 * a different ABI, e.g.
 *   1. GMP built with ABI=mode32.
 *   2. MPFR built against this GMP version.
 *   3. GMP rebuilt with ABI=32.
 */
static void failure_test (void)
{
  mpfr_t x;

  mpfr_init2 (x, 128);
  mpfr_set_str (x, "17", 0, MPFR_RNDN);
  if (mpfr_cmp_ui (x, 17) != 0)
    printf ("\nFailure in mpfr_set_str! Probably an unmatched ABI!\n");
  mpfr_clear (x);
}

int main (void)
{
  unsigned long c;
  mp_limb_t t[4] = { -1, -1, -1, -1 };

#if defined(__cplusplus)
  printf ("A C++ compiler is used.\n");
#endif

  printf ("GMP .....  Library: %-12s  Header: %d.%d.%d\n",
          gmp_version, __GNU_MP_VERSION, __GNU_MP_VERSION_MINOR,
          __GNU_MP_VERSION_PATCHLEVEL);

  printf ("MPFR ....  Library: %-12s  Header: %s (based on %d.%d.%d)\n",
          mpfr_get_version (), MPFR_VERSION_STRING, MPFR_VERSION_MAJOR,
          MPFR_VERSION_MINOR, MPFR_VERSION_PATCHLEVEL);

#if MPFR_VERSION_MAJOR >= 3
  printf ("MPFR features: TLS = %s, decimal = %s",
          mpfr_buildopt_tls_p () ? "yes" : "no",
          mpfr_buildopt_decimal_p () ? "yes" : "no");
# if MPFR_VERSION_MAJOR > 3 || MPFR_VERSION_MINOR >= 1
  printf (", GMP internals = %s\nMPFR tuning: %s",
          mpfr_buildopt_gmpinternals_p () ? "yes" : "no",
          mpfr_buildopt_tune_case ());
# endif
  printf ("\n");
#endif

  printf ("MPFR patches: %s\n\n", mpfr_get_patches ());

#ifdef __GMP_CC
  printf ("__GMP_CC = \"%s\"\n", __GMP_CC);
#endif
#ifdef __GMP_CFLAGS
  printf ("__GMP_CFLAGS = \"%s\"\n", __GMP_CFLAGS);
#endif
  printf ("GMP_LIMB_BITS     = %d\n", (int) GMP_LIMB_BITS);
  printf ("GMP_NAIL_BITS     = %d\n", (int) GMP_NAIL_BITS);
  printf ("GMP_NUMB_BITS     = %d\n", (int) GMP_NUMB_BITS);
  printf ("mp_bits_per_limb  = %d\n", (int) mp_bits_per_limb);
  printf ("sizeof(mp_limb_t) = %d\n", (int) sizeof(mp_limb_t));
  if (mp_bits_per_limb != GMP_LIMB_BITS)
    printf ("Warning! mp_bits_per_limb != GMP_LIMB_BITS\n");
  if (GMP_LIMB_BITS != sizeof(mp_limb_t) * CHAR_BIT)
    printf ("Warning! GMP_LIMB_BITS != sizeof(mp_limb_t) * CHAR_BIT\n");

  c = mpn_popcount (t, 1);
  printf ("The GMP library expects %lu bits in a mp_limb_t.\n", c);
  if (c != GMP_LIMB_BITS)
    printf ("Warning! This is different from GMP_LIMB_BITS!\n"
            "Different ABI caused by a GMP library upgrade?\n");

  printf ("\n");
  printf ("sizeof(mpfr_prec_t) = %d (%s type)\n", (int) sizeof(mpfr_prec_t),
          SIGNED_STR((mpfr_prec_t) -1));
#if MPFR_VERSION_MAJOR >= 3
  printf ("sizeof(mpfr_exp_t)  = %d (%s type)\n", (int) sizeof(mpfr_exp_t),
          SIGNED_STR((mpfr_exp_t) -1));
#endif
#ifdef _MPFR_PREC_FORMAT
  printf ("_MPFR_PREC_FORMAT = %d\n", (int) _MPFR_PREC_FORMAT);
#endif
  /* Note: "long" is sufficient for all current _MPFR_PREC_FORMAT values
     (1, 2, 3). Thus we do not need to depend on ISO C99 or later. */
  printf ("MPFR_PREC_MIN = %ld (%s)\n", (long) MPFR_PREC_MIN,
          SIGNED (MPFR_PREC_MIN));
  printf ("MPFR_PREC_MAX = %ld (%s)\n", (long) MPFR_PREC_MAX,
          SIGNED (MPFR_PREC_MAX));
#ifdef _MPFR_EXP_FORMAT
  printf ("_MPFR_EXP_FORMAT = %d\n", (int) _MPFR_EXP_FORMAT);
#endif
  printf ("sizeof(mpfr_t) = %d\n", (int) sizeof(mpfr_t));

  failure_test ();

  return 0;
}
