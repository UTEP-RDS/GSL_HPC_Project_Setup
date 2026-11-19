#include <omp.h>
#include <gsl/gsl_statistics.h>
#include <iostream>
#include <vector>

int main() {
    const std::vector<double> data = {1.0, 2.0, 3.0, 4.0, 5.0};
    const size_t size = data.size();

#pragma omp parallel
    {
        const int tid = omp_get_thread_num();

        // Scale the dataset by (thread + 1) so each thread's result is distinct
        std::vector<double> scaled(size);
        for (size_t i = 0; i < size; ++i) {
            scaled[i] = data[i] * (tid + 1);
        }

        const double mean = gsl_stats_mean(scaled.data(), 1, size);
        const double variance = gsl_stats_variance(scaled.data(), 1, size);

#pragma omp critical
        {
            std::cout << "Thread " << tid
                      << " of " << omp_get_num_threads()
                      << ": mean=" << mean
                      << " variance=" << variance
                      << std::endl;
        }
    }

    return 0;
}