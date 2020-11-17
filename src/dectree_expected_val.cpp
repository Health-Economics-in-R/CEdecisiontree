#include <Rcpp.h>
using namespace Rcpp;

//' Cdectree_expected_values
//'
//' @export
// [[Rcpp::export]]
NumericVector Cdectree_expected_values(NumericMatrix vals,
                                       NumericMatrix p){

  int num_from_nodes = vals.nrow();
  int num_to_nodes = vals.ncol();

  NumericVector c_hat(num_to_nodes);

  for (int i = 0; i < num_from_nodes; i++) {

    double total = 0;
    double k = num_from_nodes - i - 1;

    for (int j = 0; j < num_to_nodes; j++) {

      if (!NumericVector::is_na(vals(k,j))) {

        total += p(k,j)*(vals(k,j) + c_hat[j]);
      }
    }

    c_hat[k] = total;
  }

  return c_hat;
}

/*** R
*/
