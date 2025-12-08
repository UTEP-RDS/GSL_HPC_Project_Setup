#include <iostream>
#include <gsl/gsl_math.h>
#include <gsl/gsl_statistics.h>

int main() {
    // Dummy dataset
    double data[] = {1.0, 2.0, 3.0, 4.0, 5.0};
    size_t size = sizeof(data) / sizeof(data[0]);

    // Compute mean using GSL
    double mean = gsl_stats_mean(data, 1, size);

    // Compute variance using GSL
    double variance = gsl_stats_variance(data, 1, size);

    // Print results
    std::cout << "Dummy GSL Test Program" << std::endl;
    std::cout << "Data size: " << size << std::endl;
    std::cout << "Mean: " << mean << std::endl;
    std::cout << "Variance: " << variance << std::endl;

    return 0;
}

