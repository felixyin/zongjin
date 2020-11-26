package com.fy.erp.modules.erp.entity

/**
 * Created by 尹彬 on 2017/11/15.
 */
enum class SalesOrderTaskID(val flag: String) {
    BEGIN("BEGIN"),
    CREATE_PRODUCTION_PLAN("CREATE_PRODUCTION_PLAN"),
    CHECK_PRODUCTION_PLAN("CHECK_PRODUCTION_PLAN"),
    BEGIN_PAYMENT("CHECK_PRODUCTION_PLAN"),
    CHECK_BEGIN_PAYMENT("CHECK_BEGIN_PAYMENT"),
    CREATE_PRODUCTION_ORDER("CREATE_PRODUCTION_ORDER"),
    END_PAYMENT("END_PAYMENT"),
    CHECK_END_PAYMENT("CHECK_END_PAYMENT"),
    CREATE_SHIPMENTS("CREATE_SHIPMENTS"),
    CAL_SALES_COMMISSIONS("CAL_SALES_COMMISSIONS"),
    CHECK_CAL_SALES_COMMISSIONS("CHECK_CAL_SALES_COMMISSIONS"),
    END("END")
}