package com.test.SMT;

public class Sync01 {
    public static void main(String[] args) {

        MyThread thread = new MyThread();
        new Thread(thread, "买票人一").start();
        new Thread(thread, "买票人二").start();
        new Thread(thread, "买票人三").start();
    }
}

class MyThread implements Runnable{
    int ticketNum = 10000;
    boolean flag = true;
    @Override
    public void run() {
        while (flag) {
            try {
                buyTicket();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }

    private synchronized void buyTicket() throws InterruptedException {
        Thread.sleep(1);
        if(ticketNum > 0) {
            System.out.println(Thread.currentThread().getName() + ":" +ticketNum --);
        } else {
            flag = false;
        }
    }
}