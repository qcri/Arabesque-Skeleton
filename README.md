# Arabesque Project Skeleton

[http://arabesque.io](http://arabesque.io)

This repository contains a sample application built on top of Arabesque. It contains:
* A pre-configured pom.xml file for easy building with Maven.
* Execution scripts and configuration files for easily running your applications.
* Sample data file with the format Arabesque expects.

You may use it as a starting point for developing your own algorithms in Arabesque.

Arabesque and this skeleton project are open-source with the Apache 2.0 license.

## Requirements
To compile this project, you need:

* [Java Development Kit (JDK) (7 or greater)](http://www.oracle.com/technetwork/java/javase/downloads/index.html)
* [Maven](https://maven.apache.org/)

To run the compiled application, you need:

* A 64-bit JVM running under Linux or Mac.
* [A functioning installation of Hadoop2 with MapReduce (local or in a cluster)](http://www.alexjf.net/blog/distributed-systems/hadoop-yarn-installation-definitive-guide/)

## Make it yours
Fork this project using [Github](https://help.github.com/articles/fork-a-repo/) (don't forget to change the repository name!!) or manually by executing the following:

```
git clone https://github.com/Qatar-Computing-Research-Institute/Arabesque-Skeleton.git $PROJECT_PATH
cd $PROJECT_PATH
git remote rename origin upstream
git remote add origin $YOUR_REPO_URL
```

You should then edit the `pom.xml` file paying particular attention to the following lines:

```
<groupId>org.example</groupId>
<artifactId>arabesque-skeleton</artifactId>
<version>1.0</version>
<name>Arabesque Skeleton</name>
<description>Skeleton for a new project using the Arabesque system</description>
```

Give it a descriptive name and description and make sure to change the group and
artifact ids.

You should also change the following line in `bin/run_arabesque.sh` to match
your new artifactId:

```
PROJECT_NAME="arabesque-skeleton"
```

Your application code should go under the `src/main/java`. Included in this
skeleton is a sample implementation of Clique Finding which you might find a
useful starting point for your own implementations. Make sure to rename the
package and class according to your purposes.

## Compiling
You may compile this project as any other normal maven-based project.

If you execute the following command at the root of the project (where the 
`pom.xml` file is located)

```
mvn package
```

Maven will compile and package your application. The resulting jar will
be located under the `target` directory:

```
target/<artifactId>-<version>-jar-with-dependencies.jar
```

## Executing
1. In a machine with access to an Hadoop cluster, create a directory where
you'll put everything necessary to execute your computation:
  ```
  mkdir example
  cd example
  ```

2. Put all the following files in that directory (using SCP/FTP/...):
  * `<artifactId>-<version>-jar-with-dependencies.jar`
  * `run_arabesque.sh`
  * `cluster.yaml`
  * `application.yaml`
  * An input graph with the correct input format as expected by Arabesque:

    ```
    # <num vertices> <num edges>
    <vertex0Id> <vertex0Label> [<neighbour00Id> <neighbour01Id> ...]
    <vertex1Id> <vertex1Label> [<neighbour10Id> <neighbour11Id> ...]
    ...
    ```
    
    Vertex ids should be in the range between 0 and `(number of vertices - 1)`.
    
3. Upload your input graph to HDFS

  ```
  hdfs dfs -put <input graph file> <destination graph file in HDFS>
  ```
  
4. Change the settings in `cluster.yaml` and `application.yaml` to match your
cluster, application and data settings (`input_graph_path` should point to
the final path of the graph in HDFS according to the previous step).

5. To start your computation, execute the following (you should probably
clean the output directory first):

  ```
  ./run_arabesque.sh cluster.yaml application.yaml
  ```
  
6. You can check the logs of the hadoop containers for progress information.

7. When finished, you can consult the results in the `output_path` HDFS directory
as specified on the `application.yaml` configuration file.
