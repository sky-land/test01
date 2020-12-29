package com.test.SMT;

import java.util.concurrent.locks.ReentrantLock;

public class TestLock {

    public static void main(String[] args) {
        TestMyThread01 testMyThread01 = new TestMyThread01();
        new Thread(testMyThread01, "1>>").start();
        new Thread(testMyThread01, "2>>").start();
    }
}

class TestMyThread01 implements Runnable{

    int num = 100;
    private final ReentrantLock reentrantLock = new ReentrantLock();

    @Override
    public void run() {
        while (true) {
            try {
                reentrantLock.lock();
                if (num <= 0) {
                    break;
                } else {
                    try {
                        Thread.sleep(100);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                    num --;
                    System.out.println(Thread.currentThread().getName()+num);
                }

            }finally {
                reentrantLock.unlock();
            }

        }
    }
}