#ifndef CLOOG_INT_H
#define CLOOG_INT_H

#include <assert.h>
#include <stdio.h>
#if defined(CLOOG_INT_GMP)
#include <string.h>
#include <gmp.h>
#ifndef mp_get_memory_functions
void mp_get_memory_functions(
		void *(**alloc_func_ptr) (size_t),
		void *(**realloc_func_ptr) (void *, size_t, size_t),
		void (**free_func_ptr) (void *, size_t));
#endif
#endif

#if defined(__cplusplus)
extern "C" 
  {
#endif 

#if defined(CLOOG_INT_INT)
typedef int		cloog_int_t;
#define CLOOG_INT_FORMAT	"%d"
#elif defined(CLOOG_INT_LONG)
typedef long		cloog_int_t;
#define CLOOG_INT_FORMAT	"%ld"
#elif defined(CLOOG_INT_LONG_LONG)
typedef long long	cloog_int_t;
#define CLOOG_INT_FORMAT	"%lld"
#elif defined(CLOOG_INT_GMP)
typedef mpz_t		cloog_int_t;
#else
#error "No integer type defined"
#endif

#if defined(CLOOG_INT_GMP)

#define cloog_int_init(i)	mpz_init(i)
#define cloog_int_clear(i)	mpz_clear(i);

#define cloog_int_set(r,i)	mpz_set(r,i)
#define cloog_int_set_si(r,i)	mpz_set_si(r,i)
#define cloog_int_abs(r,i)	mpz_abs(r,i)
#define cloog_int_neg(r,i)	mpz_neg(r,i)
#define cloog_int_swap(i,j)	mpz_swap(i,j)

#define cloog_int_add(r,i,j)	mpz_add(r,i,j)
#define cloog_int_add_ui(r,i,j)	mpz_add_ui(r,i,j)
#define cloog_int_sub(r,i,j)	mpz_sub(r,i,j)
#define cloog_int_sub_ui(r,i,j)	mpz_sub_ui(r,i,j)
#define cloog_int_mul(r,i,j)	mpz_mul(r,i,j)
#define cloog_int_addmul(r,i,j)	mpz_addmul(r,i,j)
#define cloog_int_divexact(r,i,j)	mpz_divexact(r,i,j)
#define cloog_int_tdiv_q(r,i,j)	mpz_tdiv_q(r,i,j)
#define cloog_int_fdiv_q(r,i,j)	mpz_fdiv_q(r,i,j)
#define cloog_int_fdiv_r(r,i,j)	mpz_fdiv_r(r,i,j)
#define cloog_int_cdiv_q(r,i,j)	mpz_cdiv_q(r,i,j)
#define cloog_int_gcd(r,i,j)	mpz_gcd(r,i,j)

#define cloog_int_sgn(i)	mpz_sgn(i)
#define cloog_int_cmp(i,j)	mpz_cmp(i,j)
#define cloog_int_abs_cmp(i,j)	mpz_cmpabs(i,j)
#define cloog_int_cmp_si(i,si)	mpz_cmp_si(i,si)
#define cloog_int_eq(i,j)	(mpz_cmp(i,j) == 0)
#define cloog_int_ne(i,j)	(mpz_cmp(i,j) != 0)
#define cloog_int_gt(i,j)	(mpz_cmp(i,j) > 0)

#define cloog_int_is_divisible_by(i,j)	mpz_divisible_p(i,j)

#define cloog_int_read(r,s)	mpz_set_str(r,s,10)
typedef void (*cloog_int_print_gmp_free_t)(void *, size_t);
#define cloog_int_print(out,i)						\
	do {								\
		char *s;						\
		cloog_int_print_gmp_free_t gmp_free;			\
		s = mpz_get_str(0, 10, i);				\
		fprintf(out, "%s", s);					\
		mp_get_memory_functions(NULL, NULL, &gmp_free);		\
		(*gmp_free)(s, strlen(s)+1);				\
	} while (0)

#else

#define cloog_int_init(i)	((i) = 0)
#define cloog_int_clear(i)	do { } while (0)

#define cloog_int_set(r,i)	((r) = (i))
#define cloog_int_set_si(r,i)	((r) = (i))
#define cloog_int_abs(r,i)	((r) = (i) > 0 ? (i) : -(i))
#define cloog_int_neg(r,i)	((r) = -(i))
#define cloog_int_swap(i,j)	do {					\
					cloog_int_t _t = i;		\
					i = j;				\
					j = _t;				\
				} while (0)

#define cloog_int_add(r,i,j)	((r) = (i) + (j))
#define cloog_int_add_ui(r,i,j)	((r) = (i) + (j))
#define cloog_int_sub(r,i,j)	((r) = (i) - (j))
#define cloog_int_sub_ui(r,i,j)	((r) = (i) - (j))
#define cloog_int_mul(r,i,j)	((r) = (i) * (j))
#define cloog_int_addmul(r,i,j)	((r) += (i) * (j))
#define cloog_int_divexact(r,i,j)	((r) = (i) / (j))
#define cloog_int_tdiv_q(r,i,j)	((r) = (i) / (j))
#define cloog_int_fdiv_q(r,i,j)	do {					\
					assert((j) > 0);		\
					(r) = (i) >= 0 ? (i) / (j) :	\
					    -((-(i)+(j)-1)/(j));	\
				} while (0)
#define cloog_int_fdiv_r(r,i,j)	do {					\
					assert((j) > 0);		\
					(r) = (i) >= 0 ? (i) % (j) :	\
					    (j)-1 - ((-(i)+(j)-1)%(j));	\
				} while (0)
#define cloog_int_cdiv_q(r,i,j)	do {					\
					assert((j) > 0);		\
					(r) = (i) >= 0 ?		\
					    ((i)+(j)-1) / (j) :		\
					    -(-(i)/(j));		\
				} while (0)
cloog_int_t cloog_gcd(cloog_int_t a, cloog_int_t b);
#define cloog_int_gcd(r,i,j)	(r) = cloog_gcd(i,j)

#define cloog_int_sgn(i)	((i) > 0 ? 1 : (i) < 0 ? -1 : 0)
#define cloog_int_cmp(i,j)	(i - j)
#define cloog_int_abs_cmp(i,j)	(((i) > 0 ? (i) : -(i)) - ((j) > 0 ? (j) : -(j)))
#define cloog_int_cmp_si(i,si)	(i - si)
#define cloog_int_eq(i,j)	((i) == (j))
#define cloog_int_ne(i,j)	((i) != (j))
#define cloog_int_gt(i,j)	((i) > (j))

#define cloog_int_is_divisible_by(i,j)	((i) % (j) == 0)

#define cloog_int_read(i,s)	sscanf(s, CLOOG_INT_FORMAT, &i)
#define cloog_int_print(out,i)	fprintf(out, CLOOG_INT_FORMAT, i)

#endif

#define cloog_int_is_pos(i)	(cloog_int_sgn(i) > 0)
#define cloog_int_is_neg(i)	(cloog_int_sgn(i) < 0)
#define cloog_int_is_zero(i)	(cloog_int_sgn(i) == 0)
#define cloog_int_is_one(i)	(cloog_int_cmp_si(i,1) == 0)
#define cloog_int_is_neg_one(i)	(cloog_int_cmp_si(i,-1) == 0)
#define cloog_int_gt_si(i,si)	(cloog_int_cmp_si(i,si) > 0)
#define cloog_int_ne_si(i,j)	(cloog_int_cmp_si(i,j) != 0)
#define cloog_int_lt(i,j)	(cloog_int_cmp(i,j) < 0)
#define cloog_int_le(i,j)	(cloog_int_cmp(i,j) <= 0)
#define cloog_int_abs_ne(i,j)	(cloog_int_abs_cmp(i,j) != 0)
#define cloog_int_abs_ge(i,j)	(cloog_int_abs_cmp(i,j) >= 0)
#define cloog_int_abs_lt(i,j)	(cloog_int_abs_cmp(i,j) < 0)

struct cloog_vec {
	unsigned	size;
	cloog_int_t	*p;
};

struct cloog_vec *cloog_vec_alloc(unsigned size);
void cloog_vec_free(struct cloog_vec *vec);

int cloog_seq_first_non_zero(cloog_int_t *p, unsigned len);
void cloog_seq_cpy(cloog_int_t *dst, cloog_int_t *src, unsigned len);
void cloog_seq_neg(cloog_int_t *dst, cloog_int_t *src, unsigned len);
void cloog_seq_combine(cloog_int_t *dst, cloog_int_t m1, cloog_int_t *src1,
			cloog_int_t m2, cloog_int_t *src2, unsigned len);
void cloog_seq_gcd(cloog_int_t *p, unsigned len, cloog_int_t *gcd);
int cloog_seq_is_neg(cloog_int_t *p1, cloog_int_t *p2, unsigned len);
void cloog_seq_normalize(cloog_int_t *p, unsigned len);

#if defined(__cplusplus)
  }
#endif 

#endif
