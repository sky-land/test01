package com.test.SMT;

public class Sync02 {

    public static void main(String[] args) {
        Account account = new Account(100);
        Bank bank = new Bank(account, 10, 0);
        bank.setName("1");
        bank.start();

        Bank bank01 = new Bank(account, 10, 0);
        bank01.setName("2");
        bank01.start();
    }
}

class Account {
    int money;

    public Account() {
    }

    public Account(int money) {
        this.money = money;
    }
}

class Bank extends Thread{
    Account account;
    int drawMoney;
    int nowMoney;

    public Bank(Account account, int drawMoney, int nowMoney) {
        this.account = account;
        this.drawMoney = drawMoney;
        this.nowMoney = nowMoney;
    }

    @Override
    public void run() {
        synchronized (account) {
            if (account.money < drawMoney) {
                System.out.println(Thread.currentThread().getName() + "资金不够");
                return;
            }
            account.money = account.money - drawMoney;
            nowMoney += drawMoney;

            System.out.println(Thread.currentThread().getName() + "：" + nowMoney);
            System.out.println("银行剩余：" + account.money);
        }

    }
}