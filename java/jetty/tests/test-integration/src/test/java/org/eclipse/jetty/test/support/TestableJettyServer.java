// ========================================================================
// Copyright (c) Webtide LLC
// ------------------------------------------------------------------------
// All rights reserved. This program and the accompanying materials
// are made available under the terms of the Eclipse Public License v1.0
// and Apache License v2.0 which accompanies this distribution.
//
// The Eclipse Public License is available at 
// http://www.eclipse.org/legal/epl-v10.html
//
// The Apache License v2.0 is available at
// http://www.apache.org/licenses/LICENSE-2.0.txt
//
// You may elect to redistribute this code under either of these licenses. 
// ========================================================================

package org.eclipse.jetty.test.support;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.InetAddress;
import java.net.MalformedURLException;
import java.net.URI;
import java.net.URL;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.eclipse.jetty.http.HttpSchemes;
import org.eclipse.jetty.server.Connector;
import org.eclipse.jetty.server.Server;
import org.eclipse.jetty.xml.XmlConfiguration;
import org.junit.Assert;
import org.junit.Ignore;

/**
 * Allows for setting up a Jetty server for testing based on XML configuration files.
 */
@Ignore
public class TestableJettyServer
{
    private List<URL> xmlConfigurations;
    private Properties properties = new Properties();
    private Server server;
    private int serverPort;
    private String scheme = HttpSchemes.HTTP;

    /* Popular Directories */
    private File baseDir;
    private File testResourcesDir;

    public TestableJettyServer() throws IOException
    {
        xmlConfigurations = new ArrayList<URL>();
        properties = new Properties();

        /* Establish Popular Directories */
        String baseDirPath = System.getProperty("basedir");
        if (baseDirPath == null)
        {
            baseDirPath = System.getProperty("user.dir",".");
        }
        baseDir = new File(baseDirPath);
        properties.setProperty("test.basedir",baseDir.getAbsolutePath());

        testResourcesDir = new File(baseDirPath,"src/test/resources".replace('/',File.separatorChar));
        properties.setProperty("test.resourcesdir",testResourcesDir.getAbsolutePath());

        File testDocRoot = new File(testResourcesDir,"docroots");
        properties.setProperty("test.docroot.base",testDocRoot.getAbsolutePath());

        File targetDir = new File(baseDir,"target");
        properties.setProperty("test.targetdir",targetDir.getAbsolutePath());

        File webappsDir = new File(targetDir,"webapps");
        properties.setProperty("test.webapps",webappsDir.getAbsolutePath());

        // Write out configuration for use by ConfigurationManager.
        File testConfig = new File(targetDir,"testable-jetty-server-config.properties");
        FileOutputStream out = new FileOutputStream(testConfig);
        properties.store(out,"Generated by " + TestableJettyServer.class.getName());
    }

    public void addConfiguration(URL xmlConfig)
    {
        xmlConfigurations.add(xmlConfig);
    }

    public void addConfiguration(File xmlConfigFile) throws MalformedURLException
    {
        xmlConfigurations.add(xmlConfigFile.toURL());
    }

    public void addConfiguration(String testConfigName) throws MalformedURLException
    {
        addConfiguration(new File(testResourcesDir,testConfigName));
    }

    public void setProperty(String key, String value)
    {
        properties.setProperty(key,value);
    }

    public void load() throws Exception
    {
        XmlConfiguration last = null;
        Object[] obj = new Object[this.xmlConfigurations.size()];

        // Configure everything
        for (int i = 0; i < this.xmlConfigurations.size(); i++)
        {
            URL configURL = this.xmlConfigurations.get(i);
            XmlConfiguration configuration = new XmlConfiguration(configURL);
            if (last != null)
            {
                configuration.getIdMap().putAll(last.getIdMap());
            }
            configuration.setProperties(properties);
            obj[i] = configuration.configure();
            last = configuration;
        }

        // Test for Server Instance.
        Server foundServer = null;
        int serverCount = 0;
        for (int i = 0; i < this.xmlConfigurations.size(); i++)
        {
            if (obj[i] instanceof Server)
            {
                if (obj[i].equals(foundServer))
                {
                    // Identical server instance found
                    break;
                }
                foundServer = (Server)obj[i];
                serverCount++;
            }
        }

        if (serverCount <= 0)
        {
            throw new Exception("Load failed to configure a " + Server.class.getName());
        }

        Assert.assertEquals("Server load count",1,serverCount);

        this.server = foundServer;
        this.server.setGracefulShutdown(10);
        
    }

    public String getScheme()
    {
        return scheme;
    }

    public void setScheme(String scheme)
    {
        this.scheme = scheme;
    }

    public void start() throws Exception
    {
        Assert.assertNotNull("Server should not be null (failed load?)",server);

        server.start();

        // Find the active server port.
        this.serverPort = (-1);
        Connector connectors[] = server.getConnectors();
        for (int i = 0; i < connectors.length; i++)
        {
            Connector connector = connectors[i];
            if (connector.getLocalPort() > 0)
            {
                this.serverPort = connector.getLocalPort();
                break;
            }
        }

        Assert.assertTrue("Server Port is between 1 and 65535. Actually <" + serverPort + ">",(1 <= this.serverPort) && (this.serverPort <= 65535));
    }

    public int getServerPort()
    {
        return serverPort;
    }

    public void stop() throws Exception
    {
        server.stop();
    }

    public URI getServerURI() throws UnknownHostException
    {
        StringBuffer uri = new StringBuffer();
        uri.append(this.scheme).append("://");
        uri.append(InetAddress.getLocalHost().getHostAddress());
        uri.append(":").append(this.serverPort);
        return URI.create(uri.toString());
    }
}
