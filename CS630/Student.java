
import java.io.Console;
import java.util.Scanner;
import java.sql.*;

public class Student {
	public static final String oracleServer = "dbs3.cs.umb.edu";
	public static final String oracleServerSid = "dbs3";

	public static void main(String args[]) {
		Connection conn = null;
		conn = getConnection();
		if (conn == null)
			System.exit(1);
		boolean records = true;

		System.out.println("Enter Student ID");
		Scanner sc = new Scanner(System.in);
		int SID = sc.nextInt();

		if (SID == -1) {
			try {

				System.out.println("We need some details to enter you into our system");
				String SQL = "Insert into Students(sid, sname) values (?, ?)";
				PreparedStatement p1 = conn.prepareStatement(SQL);
				System.out.println("Enter Student ID");

				int sid = sc.nextInt();
				SID = sid;

				System.out.println("Enter Student Name");
				String Sname = sc.next();

				p1.setInt(1, sid);
				p1.setString(2, Sname);

				p1.executeUpdate();
				System.out.println("Registered Student " + Sname);

			} catch (SQLException e) {
				System.out.println("ERROR OCCURRED");
				e.printStackTrace();

			}
		}

		while (records) {

			System.out.println("Choose from menu below");
			System.out.println("L List of courses");
			System.out.println("E Enroll in a course");
			System.out.println("W Withdraw course");
			System.out.println("S Search for courses");
			System.out.println("M My Classes");
			System.out.println("X Exit");
			// all cases print

			Scanner Menu = new Scanner(System.in);
			char inputmenu = Menu.next().charAt(0);
			switch (inputmenu) {
			case 'L':

				try {
					PreparedStatement preparedStatement = null;
					System.out.println("List of all courses");
					String SQL = "select cid, cname, credits from Courses";
					preparedStatement = conn.prepareStatement(SQL);
					ResultSet rs = preparedStatement.executeQuery();
					if (rs.next()) {
						do {
							System.out.println("Course id = " + rs.getString("cid") + ", Cname = "
									+ rs.getString("cname") + ", Credits = " + rs.getString("credits"));
						} while (rs.next());
						// System.out.println();
					} else
						System.out.println("No Records Retrieved");
					rs.close();
					preparedStatement.close();

				} catch (SQLException e) {
					System.out.println("ERROR OCCURRED");
					e.printStackTrace();
				}

				break;

			case 'E':
				try {
					PreparedStatement preparedStatement = null;
					System.out.println("Choose course from below courses");
					// System.out.println("Enrolling classes for student "+sid);
					String SQL = "select cid, cname from Courses";
					preparedStatement = conn.prepareStatement(SQL);
					ResultSet rs = preparedStatement.executeQuery();
					if (rs.next()) {
						do {
							System.out.println("CID = " + rs.getString("CID") + ", CNAME = " + rs.getString("CNAME"));
						} while (rs.next());
					} else
						System.out.println("No Records Retrieved");
					System.out.println("Enter Course ID");
					// Scanner sc = new Scanner(System.in);
					int courseid = sc.nextInt();
					String SQL1 = "Insert into Enrolled (sid, cid) values (?, ?)";
					preparedStatement = conn.prepareStatement(SQL1);
					preparedStatement.setInt(1, SID);
					preparedStatement.setInt(2, courseid);
					preparedStatement.executeUpdate();
					System.out.println("Enrolled " + courseid);
					rs.close();
					preparedStatement.close();
				} catch (SQLException e) {
					System.out.println("Already registered");
					// e.printStackTrace();
				}

				break;

			case 'W':

				try {

					String SQL = "Delete from Enrolled where cid = ? and sid = ?";
					PreparedStatement preparedStatement = conn.prepareStatement(SQL);
					System.out.println("Enter Course ID");
					// Scanner sc = new Scanner(System.in);
					int courseid = sc.nextInt();

					preparedStatement.setInt(2, SID);
					preparedStatement.setInt(1, courseid);
					int D = preparedStatement.executeUpdate();
					System.out.println(D + " Deleted");
					preparedStatement.close();

				} catch (SQLException e) {
					System.out.println("Course doesn't exist");
					// e.printStackTrace();
				}

				break;

			case 'M':

				try {
					PreparedStatement preparedStatement = null;
					// System.out.println("Choose course from below courses");
					String SQL = "select c.cid, c.cname from  Courses c, Enrolled E where c.cid = E.cid and E.sid = ? ";
					preparedStatement = conn.prepareStatement(SQL);
					preparedStatement.setInt(1, SID);

					ResultSet rs = preparedStatement.executeQuery();
					if (rs.next()) {
						do {
							System.out.println(
									"Courseid = " + rs.getString("cid") + ", Cname = " + rs.getString("cname"));
						} while (rs.next());
					} else
						System.out.println("No Records Retrieved");
					rs.close();
					preparedStatement.close();

				} catch (SQLException e) {
					System.out.println("ERROR OCCURRED");
					// e.printStackTrace();
				}

				break;

			case 'S':

				try {
					PreparedStatement preparedStatement = null;
					String SQL = "select cid, cname from  Courses where cname LIKE ? ";
					preparedStatement = conn.prepareStatement(SQL);
					System.out.println("Course name you wanna search for");
					String cname = sc.next();
					preparedStatement.setString(1, "%" + cname + "%");
					ResultSet rs = preparedStatement.executeQuery();
					if (rs.next()) {
						do {
							System.out.println(
									"Courseid = " + rs.getString("cid") + ", Cname = " + rs.getString("cname"));
						} while (rs.next());
					} else
						System.out.println("No Records Retrieved");
					rs.close();
					preparedStatement.close();

				} catch (SQLException e) {
					System.out.println("ERROR OCCURRED");
					e.printStackTrace();
				}

				break;

			case 'X':
				records = false;
				break;

			default:
				System.out.println("The Menu you chose doesn't exist please choose from existing");

			}

		} // while
	}

	public static Connection getConnection() {

		// first we need to load the driver
		String jdbcDriver = "oracle.jdbc.OracleDriver";
		try {
			Class.forName(jdbcDriver);
		} catch (Exception e) {
			e.printStackTrace();
		}

		// Get username and password
		Scanner input = new Scanner(System.in);
		System.out.print("Username:");
		String username = input.nextLine();
		System.out.print("Password:");
		// the following is used to mask the password
		Console console = System.console();
		String password = new String(console.readPassword());
		String connString = "jdbc:oracle:thin:@" + oracleServer + ":1521:" + oracleServerSid;

		System.out.println("Connecting to the database...");

		Connection conn;
		// Connect to the database
		try {
			conn = DriverManager.getConnection(connString, username, password);
			System.out.println("Connection Successful");
		} catch (SQLException e) {
			System.out.println("Connection ERROR");
			e.printStackTrace();
			return null;
		}

		return conn;
	}
}
