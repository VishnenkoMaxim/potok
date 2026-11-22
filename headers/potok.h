//
// Created by vimax on 11/22/26.
//

#pragma once

#include <iostream>
#include <memory>
#include <string>
#include <vector>
#include <cstring>
#include <algorithm>
#include <fstream>

#include <spdlog/spdlog.h>

#include "spdlog/sinks/rotating_file_sink.h"

constexpr auto log_path = "/opt/potok/log/potok.log";
constexpr auto log_max_size = 10*1024*1024;
constexpr auto log_max_files = 10;