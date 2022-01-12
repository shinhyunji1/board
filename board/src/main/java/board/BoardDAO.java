package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BoardDAO {

  private Connection conn;
  private ResultSet rs;

  public BoardDAO() {
    try {
      String dbURL="jdbc:mariadb://localhost:3306/board";
      String dbID="root";
      String dbPassword="1111";
      Class.forName("org.mariadb.jdbc.Driver");
      conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
    } catch (Exception e) {
      e.printStackTrace();
    }

  }

  //작성일자를 구하는 메서드( 현재 날짜와 시간을 출력)
  public String getDate() {
    String sql = "select now()";
    try {
      PreparedStatement pstmt = conn.prepareStatement(sql);
      rs = pstmt.executeQuery();
      if (rs.next()) {
        return rs.getString(1);
      }
    } catch(Exception e) {
      e.printStackTrace();
    }
    return "";
  }

  //새로운 게시글 번호 부여
  public int getNext() {
    String sql = "select no from board order by no desc";
    try {
      PreparedStatement pstmt = conn.prepareStatement(sql);
      rs = pstmt.executeQuery();
      if (rs.next()) {
        return rs.getInt(1) + 1;
      }
      return 1; // 첫 번째 게시물인 경우
    } catch(Exception e) {
      e.printStackTrace();
    }
    return -1; // 데이터베이스 오류
  }

  public int write(String title, String id, String content) {
    String sql = "insert into board(no, title, id, date, content, available) values(?,?,?,?,?,?)";
    try {
      PreparedStatement pstmt = conn.prepareStatement(sql);
      pstmt.setInt(1, getNext());
      pstmt.setString(2, title);
      pstmt.setString(3, id);
      pstmt.setString(4, getDate());
      pstmt.setString(5, content);
      pstmt.setInt(6, 1);
      return pstmt.executeUpdate();
    } catch(Exception e) {
      e.printStackTrace();
    }
    return -1;
  }

  public ArrayList<Board> getList(int pageNumber){
    String sql = "select * from board where no < ? and available = 1 order by no desc limit 10";
    ArrayList<Board> list = new ArrayList<Board>();
    try {
      PreparedStatement pstmt = conn.prepareStatement(sql);
      pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
      rs = pstmt.executeQuery();
      while (rs.next()) {
        Board board = new Board();
        board.setNo(rs.getInt(1));
        board.setTitle(rs.getString(2));
        board.setId(rs.getString(3));
        board.setDate(rs.getString(4));
        board.setContent(rs.getString(5));
        board.setAvailable(rs.getInt(6));
        list.add(board);
      }
    } catch(Exception e) {
      e.printStackTrace();
    }
    return list;
  }

  public boolean nextPage(int pageNumber) {
    String sql = "select * from board where no < ? and available = 1";
    try {
      PreparedStatement pstmt = conn.prepareStatement(sql);
      pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
      rs = pstmt.executeQuery();
      if (rs.next()) {
        return true;
      }
    } catch(Exception e) {
      e.printStackTrace();
    }
    return false; 
  }

  //하나의 게시글을 보는 메소드
  public Board getBoard(int no) {
    String sql = "select * from board where no = ?";
    try {
      PreparedStatement pstmt = conn.prepareStatement(sql);
      pstmt.setInt(1, no);
      rs = pstmt.executeQuery();
      if(rs.next()) {
        Board board = new Board();
        board.setNo(rs.getInt(1));
        board.setTitle(rs.getString(2));
        board.setId(rs.getString(3));
        board.setDate(rs.getString(4));
        board.setContent(rs.getString(5));
        board.setAvailable(rs.getInt(6));
        return board;
      }
    }catch (Exception e) {
      e.printStackTrace();
    }
    return null;
  }

  //게시글 수정 메소드
  public int update(int no, String title, String content) {
    String sql = "update board set title = ?, content = ? where no = ?";
    try {
      PreparedStatement pstmt = conn.prepareStatement(sql);
      pstmt.setString(1, title);
      pstmt.setString(2, content);
      pstmt.setInt(3, no);
      return pstmt.executeUpdate();
    }catch (Exception e) {
      e.printStackTrace();
    }
    return -1; //데이터베이스 오류
  }

  //게시글 삭제 메소드
  public int delete(int no) {
    //실제 데이터를 삭제하는 것이 아니라 게시글 유효숫자를 '0'으로 수정한다
    String sql = "update board set available = 0 where no = ?";
    try {
      PreparedStatement pstmt = conn.prepareStatement(sql);
      pstmt.setInt(1, no);
      return pstmt.executeUpdate();
    }catch (Exception e) {
      e.printStackTrace();
    }
    return -1; //데이터베이스 오류 
  }

}
