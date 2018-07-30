/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package johnny.gamestore.mysql.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.nio.file.Paths;
import javax.servlet.ServletContext;

/**
 *
 * @author Johnny
 */
public class SerializeHelper {
    public static String root_directory = "";
    public static void writeToFile(String filename, Object data){
        try{           
            File file = new File(Paths.get(root_directory,filename).toString());
            FileOutputStream fos = new FileOutputStream(file);
            ObjectOutputStream oos = new ObjectOutputStream(fos);
            oos.writeObject(data);
            oos.flush();
            oos.close();
            fos.close();
        }catch(Exception e){
            System.out.println("Could NOT Write data to file " + filename);
        }
    }
    
    public static Object readFromFile(String filename) {
        Object data = null;
        try{
            File file = new File(Paths.get(root_directory,filename).toString());
            String ap = file.getAbsolutePath();
            FileInputStream fis = new FileInputStream(file);
            ObjectInputStream ois = new ObjectInputStream(fis);
            data = ois.readObject();

            ois.close();
            fis.close();            
        } catch(Exception e){
            System.out.println("Could NOT Read data from file: " + filename);
        }
        return data;
    }
    
    public static boolean exsitDataFile(String filename) {
        try{
            File file = new File(Paths.get(root_directory,filename).toString());
            String ap = file.getAbsolutePath();
            return file.exists() && !file.isDirectory();
        } catch(Exception e){
            System.out.println("Error occurs when opening file: " + filename);
        }
        return false;
    }
}
