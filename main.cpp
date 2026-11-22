#include <iostream>

#include "potok.h"


using namespace std;

int main() {
    try
    {
        auto logger = spdlog::rotating_logger_mt("main", log_path, log_max_size, log_max_files);
        logger->flush_on(spdlog::level::debug);
        
        spdlog::set_default_logger(logger);
        spdlog::set_level(spdlog::level::level_enum::debug);
    }
    catch (const spdlog::spdlog_ex& ex)
    {
        std::cerr << "Log init failed: " << ex.what() << std::endl;
        return 1;
    }
    spdlog::info("potok START");
    try
    {

    }
    catch (const std::exception & e)
    {
        spdlog::error("Exception: " + std::string(e.what()));
    }
    spdlog::info("potok STOP");
    return 0;
}
