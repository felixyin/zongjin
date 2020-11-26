package com.fy.erp;

import com.fy.erp.modules.sys.service.SystemService;

public class Password {
    public static void main(String[] args) {
        String s = SystemService.entryptPassword("123456");
        System.out.println(s);
    }
}
