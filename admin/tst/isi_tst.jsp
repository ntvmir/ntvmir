<%@ page language="Java" %>
<%@ page contentType="text/html; charset=windows-1251"%>
<%@page import="java.io.*"%>
<%@page import="java.util.Properties"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Hashtable"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.zip.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="tengry.cms.*"%>
<%@page import="tengry.cms.press.News"%>

<%!
	public static final String SERVICE_CODE = "isinews";
	
	/** CMS property with ISI upload folder name */
	public static final String ISI_UPLOAD_DIR_PROP	= "isi.dir.upload";
	/** CMS property with ISI news-pixes folder name */	
	public static final String ISI_IMAGE_DIR_PROP	= "isi.dir.image";
	/** CMS property with ISI fields description file */
	public static final String ISI_FIELDS_FILE_PROP = "isi.fields";
	
	
	/** System property with ISIDeamon object */
	public static final String ISI_DEMON_SYS_PROP	= "isi.demon";
	

	/** Stored (in db) property with default news-page-id where ISI news will bind to */
	public static final String ISI_NEWS_PAGE_ID_PROP = "isi.news.pageid";
	
	/** Stored (in db) property with ISI demon period duration */
	public static final String ISI_DEMON_PERIOD_PROP   = "isi.period";
	
	/** Stored (in db) property with ISI demon last process start datetime */
	public static final String ISI_LAST_PROCESS_PROP   = "isi.process.laststart";

	
	/** format (for SimplaDateFormat) of ISI_LAST_PROCESS_PROP property	 */
	public static final String ISI_LAST_DATE_FORMAT = "dd.MM.yyyy HH.mm";
	
	/**	If ISI_DEMON_PERIOD_PROP is not present, use this */
	public static final long ISI_DEFAULT_PERIOD_IN_MILLIS = 24 * 60 * 60 * 1000;
	
	/** The subfolder name to archive ISI's .zip fils */
	public static final String ISI_ARC_DIR_NAME		= "arc";


	public static final String PROP_NEWS_DATE_FORMAT = "news.date.format";
	public static final String PROP_NEWS_DATE = "news.date";
	public static final String PROP_NEWS_TITLE = "news.title";
	
	public static final String ENCODING = "Cp1251";
	public static final int BRIEF_MAX_LENGTH = 250;
	public static final int TITLE_MAX_LENGTH = 100;

	public static final int BUF_SIZE = 2048;

	private File m_file;
	private Hashtable m_fields;
	private SimpleDateFormat m_sdf;
	private File m_img_dir;
	private String m_news_page_id;
	
	
	public void initProcessor(File f, Properties prop, String newsPageId, JspWriter out) throws IOException
	{
		try
		{
			m_news_page_id = newsPageId;
			m_file = f;
			m_fields = new Hashtable();
			m_sdf = new SimpleDateFormat("yyMMdd");
			
			out.println( "[Northgas] ISI process: " + m_file.getPath() + " at " + new Date());
			
			
			if(prop != null)
			{
				String sdf = prop.getProperty(PROP_NEWS_DATE_FORMAT);
				if(sdf != null)
					m_sdf = new SimpleDateFormat(sdf.trim());
				Enumeration enum = prop.propertyNames();
				while(enum.hasMoreElements())
				{
					String key = (String)enum.nextElement();
					if(!PROP_NEWS_DATE_FORMAT.equals(key));
					m_fields.put(prop.getProperty(key),  key.toLowerCase());
				}
			}
		}catch(Exception e)
		{
			out.println( "[Northgas] ISI process: " + e );
		}
	}
	

	public void process(JspWriter out) throws Exception
	{
		ZipInputStream zis = new ZipInputStream(new FileInputStream(m_file));
		try
		{
			ZipEntry ze;
			while((ze = zis.getNextEntry()) != null) {
				String name = ze.getName().toLowerCase();
				out.println("ZipEntity: " + name);
				if(name.endsWith(".html") || name.endsWith(".htm"))
					processHTML(zis, ze.getName(), out);
				if(name.endsWith(".gif") || name.endsWith(".jpeg") || name.endsWith(".jpg"))
					processIMG(zis, ze.getName(), out);
			}
		}
		finally
		{
			zis.close();
		}
	}
	
	
	
	private StringBuffer readEntry(InputStream in) throws Exception
	{
		StringBuffer sb = new StringBuffer();
		byte [] b = new byte[BUF_SIZE];
		while(in.read(b) > 0)
			sb.append(new String(b, ENCODING));
		return sb;
	}
	
	
	private final String IMG_START = "<IMG ";
	private final String SRC_START = "SRC=\"";
	
	protected void processHTML(InputStream in, String file, JspWriter out) throws Exception
	{
		String sDate = null;
		String sTitle = null;
		StringBuffer text = new StringBuffer();
		
		boolean inImg = false;
		

		StringBuffer sb = readEntry(in);
		int ptr = 0;
		out.println(sb);
/*		while(ptr < sb.length())
		{
			char c = sb.charAt(ptr);
			
			// process meta tag  ( <!FIELDS ............ > )
			if(c == '<' && ptr+1 < sb.length() && sb.charAt(ptr+1) == '!')
			{
				ptr += 2;
				String metaName = readToken(sb, ptr);
				ptr += metaName.length();
				metaName = metaName.trim().toUpperCase();
				
				// proces meta tag fields
				while(ptr < sb.length() && sb.charAt(ptr) != '>')
				{
					String fieldName = readToken(sb, ptr);
					ptr += fieldName.length();
					fieldName = fieldName.trim().toUpperCase();
				
					int p;
					String value = skipTo(sb, ptr, ">\n");  
					String field = (String)m_fields.get(metaName + "." + fieldName);
					ptr += value.length();
					if(field != null)
					{
						if(value.length() > 0 && value.startsWith(":"))
							value = value.substring(1);
						value = value.trim();
						if(PROP_NEWS_DATE.equals(field))
							sDate = value;
						else if(PROP_NEWS_TITLE.equals(field))
							sTitle = value;
					}
				}
				
				// skip '>' char
				ptr ++;
				if(ptr < sb.length())
					c = sb.charAt(ptr);
				else
					c = ' ';
				
			}// end meta tag process
			
			
			// If <img...> tag finished
			if(inImg && c == '>')
			   inImg = false;
			// If <img...> tag foung
			if(c == '<' && ptr + IMG_START.length() < sb.length() && 
			   IMG_START.equals(sb.substring(ptr, ptr + IMG_START.length()).toUpperCase()))
				inImg = true;
			// If ..src=""..  found
			if(inImg && ptr + SRC_START.length() < sb.length() && 
			   SRC_START.equals(sb.substring(ptr, ptr + SRC_START.length()).toUpperCase()))
			{
				text.append(SRC_START + m_img_dir);
				ptr += SRC_START.length();
				c = sb.charAt(ptr);
				inImg = false;
			}
			text.append(c);
			ptr++;
		}
		if(sTitle == null || sTitle.length() == 0)
			sTitle = CMSApplication.removeTags(cut(text, TITLE_MAX_LENGTH));
		String brief = 	CMSApplication.removeTags(cut(text, BRIEF_MAX_LENGTH));
		Date date = null;
		if(sDate != null && sDate.length() > 0)
			try{ date = m_sdf.parse(sDate); }catch(Exception e){}
		if(date == null)
			date = new Date();
		
		news.setWebPageId(m_news_page_id);
		news.setCaptionRus(sTitle);
		news.setCaptionEng(sTitle);
		news.setBriefRus(brief);
		news.setBriefEng(brief);
		news.setContentRus(text.toString());
		news.setContentEng(text.toString());
		news.setRecordDate(date);
		news.setVisibleRus(true);
		news.setVisibleEng(true);
		try
		{
			news.save();
		}
		catch(Exception e)
		{
		}
	*/
	}
	
	protected void processIMG(InputStream in, String file, JspWriter out) throws IOException
	{
		if(out != null)
		{
		}
	}
	
	
	/** make String starting as well as StringBuffer, but not more then <code>l<code> length
	 */
	private String cut(StringBuffer b, int l)
	{
		if(b.length() <= l)
			return b.toString();
		String s = b.substring(0, l);
		int p = s.lastIndexOf(' ');
		if(p > 0)
			return s.substring(0, p) + "...";
		return s + "...";
	}
	
	/** reads the identifier (char sequense consists of letters, nums and underscores)
	 *  with its trailing space-chars (' ', '\t', '\n', '\r')
	 */
	public String readToken(StringBuffer sb, int ptr)
	{
		int p = ptr;
		while(ptr < sb.length())
		{
			char c = sb.charAt(ptr);
			if(!Character.isLetterOrDigit(c) && !Character.isSpaceChar(c) && c != '_' && c != '\n')
				break;
			ptr++;
		}
		return sb.substring(p, ptr);
	}
	
	/** Skip (and returns skiped substring) all chars in StringBuffer untill meeting
	 *  symbols from chars String
	 */
	public String skipTo(StringBuffer sb, int ptr, String chars)
	{
		int p = ptr;
		while(ptr < sb.length())
		{
			char c = sb.charAt(ptr);
			if(chars.indexOf(c) >= 0) 
				break;
			ptr++;
		}
		return sb.substring(p, ptr);
	}


private Properties m_properties;


public void startAll(JspWriter out) throws IOException
{
	out.println("StartAll");
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(ISI_LAST_DATE_FORMAT);

	m_properties = new Properties();
	String isiFieldsFile = CMSApplication.getApplication().getProperty(ISI_FIELDS_FILE_PROP);
	File file = new File(isiFieldsFile);
	try
	{
		if(file.exists())
		{
			InputStream in = new FileInputStream(file);
			try
			{
				m_properties.load(in);
			}
			finally
			{
				in.close();
			}
		}
	}
	catch(Exception e)
	{
		out.println( "[Northgas] ISIDemon can't init fields ptoperties");
	}

	String uploadDir = CMSApplication.getApplication().getProperty(ISI_UPLOAD_DIR_PROP);
	try
	{
		CMSApplication.getApplication().setStoredProperty(ISI_LAST_PROCESS_PROP, sdf.format(new Date()));
		File	dir	= new File(uploadDir);
		File[]	files	= dir.listFiles();
		for(int i = 0; files != null && i < files.length; i++)
		{
			String fileName = files[i].getName();
			try
			{
				if(files[i].isFile() && files[i].getName().toLowerCase().endsWith(".zip"))
				{
					initProcessor(files[i], m_properties, CMSApplication.getApplication().getStoredProperty(ISI_NEWS_PAGE_ID_PROP), out);
					process(out);
				}
			}
			catch(Exception e)
			{
				out.println( "[Northgas] ISI: Exception while process " + fileName + " file:");
				out.println(e);
			}
		}
	}
	catch(Exception e)
	{
		out.println( "[Northgas] ISI: Exception while process upload dir " + uploadDir + ":");
		out.println(e);
	}
}
%>




<%
//	startAll(out);

java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("hh:mm ss");
int i = 0;
String sPeriod = CMSApplication.getApplication().getStoredProperty(ISI_DEMON_PERIOD_PROP);
out.println("period = " + sPeriod + "<BR>");
long period = 1000;
try{  period = Long.parseLong(request .getParameter("period")); }catch(Exception e){}
out.println("period = " + period + "<BR>");

while(true)
{
	out.println("loop start: " + sdf.format(new Date()) + "<BR>");
				
	long nextTime = System.currentTimeMillis() + period;
	out.println("do something<BR>");
	out.println("Sleep for " + (nextTime - System.currentTimeMillis()) + "<BR><BR>");
    out.flush();
    Thread.currentThread().sleep(nextTime - System.currentTimeMillis());
	i++;
    if(i > 5) break;
}
%>

