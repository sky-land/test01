package com.test.SMT;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Test {
    public final static Date changeDateBaseTime(String time){
        String formatTime = time;
        if(time.endsWith("Z")){
            formatTime = time.substring(0, 4) + "-" + time.substring(4, 6) + "-" + time.substring(6, 8);
            time = formatTime + " " + time.substring(8, 10) + ":" + time.substring(10, 12) + ":" + time.substring(12, 14);
        }
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat dateFormat01 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        java.util.Date timeDate = null;
        try {
            System.out.println("dateFormat01=>" + dateFormat01.parse(time));
            System.out.println("dateFormat=>" + dateFormat.parse(time));
            timeDate = dateFormat.parse(time);

        } catch (ParseException e) {
        }//util¿‡–Õ
        return timeDate;
    }

    public static void main(String[] args) {
        System.out.println(changeDateBaseTime("20200728223744.107Z"));
    }
}
