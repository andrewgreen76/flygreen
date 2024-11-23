// https://docs.oracle.com/javase/tutorial/networking/datagrams/clientServer.html

import java.io.*;

public class QuoteServer {
    public static void main(String[] args) throws IOException {
        new QuoteServerThread().start();
    }
}
