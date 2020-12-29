package com.test.SMT;

public class PCConduit {
    public static void main(String[] args) {
        SynContainer synContainer = new SynContainer();

        new Provider(synContainer).start();
        new Consumer(synContainer).start();
    }
}

class Provider extends Thread{
    SynContainer synContainer;

    public Provider(SynContainer synContainer) {
        this.synContainer = synContainer;
    }

    @Override
    public void run() {
        for (int i = 1; i < 100; i++) {
            try {
                synContainer.push(new Product(i));
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            System.out.println("生产" + i);
        }
    }
}

class Consumer extends Thread{
    SynContainer synContainer;

    public Consumer(SynContainer synContainer) {
        this.synContainer = synContainer;
    }

    @Override
    public void run() {
        for (int i = 1; i < 100; i++) {
            try {
                System.out.println("消费" + synContainer.pop().id);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}

class Product {
    int id;

    public Product(int id) {
        this.id = id;
    }
}

class SynContainer{
    Product[] products = new Product[100];
    int index = 0;

    public synchronized void push(Product product) throws InterruptedException {
        if(products.length == index) {
            this.wait();
        }
        products[index] = product;
        index ++;
        this.notifyAll();
    }

    public synchronized Product pop() throws InterruptedException {
        if(0 == index) {
            this.wait();
        }
        index --;
        Product product = products[index];
        this.notifyAll();
        return product;
    }

}