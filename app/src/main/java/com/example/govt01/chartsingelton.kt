package com.example.govt01

import com.example.govt01.chart.CHARTDATA

object chartsingelton {
    // Shared chart data holder
    var chartData: List<Pair<Long, Double>> = emptyList()
}
