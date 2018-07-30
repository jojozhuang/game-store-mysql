/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package johnny.gamestore.mysql.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import johnny.gamestore.mysql.beans.Game;
import johnny.gamestore.mysql.beans.Review;
import johnny.gamestore.mysql.common.Constants;
import johnny.gamestore.mysql.common.SerializeHelper;

/**
 *
 * @author Johnny
 */
public class GameDao {
    private static GameDao dao;
    private static List<Game> games = new ArrayList<Game>();
    private GameDao() {}
    
    public static synchronized GameDao createInstance() {
        if (dao == null) {
            dao = new GameDao();
            init();
        }
        return dao;
    }
    
    private static void init() {
        if (SerializeHelper.exsitDataFile(Constants.DATA_FILE_GAME)) {
            games = (List<Game>)SerializeHelper.readFromFile(Constants.DATA_FILE_GAME);
        } else {
            games = new ArrayList<Game>();
            Game ea_fifa = new Game("ea_fifa", Constants.CONST_ELECTRONICARTS_LOWER, "FIFA 2016",59.99,"games/ea_fifa.jpg",Constants.CONST_ELECTRONICARTS,"New",10);
            Game ea_nfs = new Game("ea_nfs", Constants.CONST_ELECTRONICARTS_LOWER,"Need for Speed",59.99,"games/ea_nfs.jpg",Constants.CONST_ELECTRONICARTS,"New",10);
            ArrayList<Review> list = new ArrayList<Review>();
            Review review = new Review("1", ea_nfs.getKey(), "customer", 5, new Date(), "Great game, I spent all weekend playing with it.");
            list.add(review);
            ea_nfs.setReviews(list);
            games.add(ea_fifa);
            games.add(ea_nfs);
            Game activision_cod = new Game("activision_cod", Constants.CONST_ACTIVISION_LOWER, "Call Of Duty",54.99,"games/activision_cod.jpg",Constants.CONST_ACTIVISION,"New",10);
            games.add(activision_cod);
            Game tti_evolve = new Game("tti_evolve", Constants.CONST_TAKETWOINTERACTIVE_LOWER, "Evolve",49.99,"games/tti_evolve.jpg",Constants.CONST_TAKETWOINTERACTIVE,"New",10);
            games.add(tti_evolve);
            SerializeHelper.writeToFile(Constants.DATA_FILE_GAME, games);
        }
    }
    
    public List<Game> getGameList() {        
        return games;
    }
    
    public List<Game> getGameList(String maker) {
        if (maker==null || maker.isEmpty()) {
            return games;
        }

        List<Game> res = new ArrayList<Game>();
        for(Game game : games) {
            if (game.getMaker().equalsIgnoreCase(maker)) {
                res.add(game);
            }
        }
        return res;
    }
    
    public Game getGame(String key) {
        for (Game game: games) {
            if (game.getKey().equalsIgnoreCase(key)) {
                return game;
            }
        }
        return null;
    }
    
    public boolean isExisted(String key) {
        return getGame(key) == null ? false : true;
    }
    
    public void addGame(Game game) {
        games.add(game);
        SerializeHelper.writeToFile(Constants.DATA_FILE_GAME, games);
    }
    
    public void updateGame() {
        SerializeHelper.writeToFile(Constants.DATA_FILE_GAME, games);
    }
    
    public void deleteGame(String key) {
        if (games==null || games.isEmpty()) {
            return;
        } 
        
        Game game = getGame(key);
        if (game==null) {
            return;
        } else {
            games.remove(game);
        }        
        SerializeHelper.writeToFile(Constants.DATA_FILE_GAME, games);
    }
    
    public void addGameReview(String key, Review review) {
        Game game = getGame(key);
        if (game != null) {
            game.getReviews().add(0, review);
            SerializeHelper.writeToFile(Constants.DATA_FILE_GAME, games);
        }
    }
}
