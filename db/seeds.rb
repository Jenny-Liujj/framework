# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create([
  {
    email: 'dongli.init@gmail.com',
    username: 'dongli',
    password: '12345678',
    password_confirmation: '12345678'
  }
])

Post.create([
  {
    user_id: 1,
    title: 'Infinite loop in random.tcc (GCC 6.1.0) (May be bug in Armadillo)',
    content: <<-EOT
I found the C++ 11 random number generator in GCC 6.1.0 causes codes stuck in Mac OS X 10.11.5, a simple code snippet is as following:

#include <iostream>
#include <armadillo>

using namespace std;
using namespace arma;

int main(int argc, char const* argv[])
{
    cout << "check 1" << endl;
    cout << arma_rng::randn<double>() << endl;
    cout << "check 2" << endl;
    return 0;
}
I debugged this code by using lldb, and locked the suspicious part in random.tcc file of libstdc++:

/**
 * Polar method due to Marsaglia.
 *
 * Devroye, L. Non-Uniform Random Variates Generation. Springer-Verlag,
 * New York, 1986, Ch. V, Sect. 4.4.
 */
template<typename _RealType>
  template<typename _UniformRandomNumberGenerator>
    typename normal_distribution<_RealType>::result_type
    normal_distribution<_RealType>::
    operator()(_UniformRandomNumberGenerator& __urng,
       const param_type& __param)
    {
  result_type __ret;
  __detail::_Adaptor<_UniformRandomNumberGenerator, result_type>
    __aurng(__urng);

  if (_M_saved_available)
    {
      _M_saved_available = false;
      __ret = _M_saved;
    }
  else
    {
      result_type __x, __y, __r2;
      do
        {
      __x = result_type(2.0) * __aurng() - 1.0;
      __y = result_type(2.0) * __aurng() - 1.0;
      __r2 = __x * __x + __y * __y;
        }
      while (__r2 > 1.0 || __r2 == 0.0);

      const result_type __mult = std::sqrt(-2 * std::log(__r2) / __r2);
      _M_saved = __x * __mult;
      _M_saved_available = true;
      __ret = __y * __mult;
    }

  __ret = __ret * __param.stddev() + __param.mean();
  return __ret;
    }
where __aurng() always return 0, so __r2 > 1.0 || __r2 == 0.0 will never be met.

UPDATE:

I found it may be a bug in Armadillo library, since I tried the following codes which is OK:

#include <iostream>
#include <random>

using namespace std;

int main(int argc, const char *argv[])
{
    mt19937_64 rng;
    normal_distribution<double> dist;

    cout << dist(rng) << endl;

    return 0;
}
    EOT
  }
])
