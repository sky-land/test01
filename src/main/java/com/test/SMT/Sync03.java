package com.test.SMT;

import java.util.ArrayList;
import java.util.List;

public class Sync03 {

    public static void main(String[] args) {
        List list = new ArrayList();

        for (int i = 0; i < 1000; i++) {
            new Thread(() -> {
                //synchronized (list) {
                    list.add(Thread.currentThread().getName());
                //}
            }).start();
        };
        try {
            Thread.sleep(3000);
        }catch (Exception e) {}

        System.out.println(list.size());
    }
}
