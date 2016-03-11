//
//  PerfectHandlers.swift
//  HelloWorld
//
//  Created by jiapinghui on 16/3/2.
//  Copyright HO 2016年. All rights reserved.
//

import PerfectLib
import MySQL


let HOST = "localhost"
let USER = "root"
let PASSWORD = "jph199137p"
let SCHEME = "Creep"


public func PerfectServerModuleInit() {
	
	Routing.Handler.registerGlobally()
    Routing.Routes["GET", ["/jph"]] = { (_:WebResponse) in return PerfectHandler() }
    print("\(Routing.Routes.description)")
    
    Routing.Routes["GET", ["/jph2"]] = { (_:WebResponse) in return RonnieHandler() }
    
    Routing.Routes["POST", "/user/{keyid}"] = { (_:WebResponse) in return Echo3Handler() }
    
    /** student */
    Routing.Routes["GET","api/students"] = {(_:WebResponse) in return StudentHandler() }
    
    /** class */
    Routing.Routes["GET","api/classes"] = {(_:WebResponse) in return StudentHandler() }
    
    /** grade
      * 参数1 c_id
      * 参数2 s_id
    */
    Routing.Routes["POST","api/grade"] = {(_:WebResponse) in return GradeHandler() }
}


class PerfectHandler: RequestHandler {
    func handleRequest(request: WebRequest, response: WebResponse) {
        response.addHeader("Content-Type", value: "application/json")
        response.addHeader("Content-Type", value: "text/html; charset=utf-8")
        
        let mysql = MySQL()
        let connect = mysql.connect(HOST,user: USER,password: PASSWORD)
        if (connect) {
            let sres = mysql.selectDatabase(SCHEME)
            if (sres) {
                let sres2 = mysql.query("SELECT name,sex,age,height,weight,keyid,diploma,cardid,birthday FROM personInfo")
                if (sres2) {
                    let results = mysql.storeResults()!
                    if (results.numRows() == 0) {
                        do {
                            let encode = JSONEncoder()
                            let data = try encode.encode(["result":"","success":false,"returnMessae":"could not create data"])
                            response.appendBodyString(data)
                        }
                        
                        catch {
                            response.setStatus(500, message: "Could not create data")
                        }
                    } else {
                        var dataArray:Array<AnyObject> = []
                        var dict = Dictionary<String,String>()
                        while let row = results.next() {
                            dict["name"] = row[0];
                            dict["sex"] = row[1];
                            dict["age"] = row[2];
                            dict["height"] = row[3];
                            dict["weight"] = row[4];
                            dict["keyid"] = row[5];
                            dict["diploma"] = row[6];
                            dict["cardid"] = row[7];
                            dict["birthday"] = row[8];
                            dataArray.append(dict)
                        }
                        print(NSJSONSerialization.isValidJSONObject(dataArray))
                        
                        do {
                            var dict = Dictionary<String,AnyObject>()
                            dict["result"] = dataArray
                            dict["success"] = true
                            dict["returnMessage"]=""
                            let dataFinal = try NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions(rawValue: 0))
                            let string = NSString(data: dataFinal, encoding: NSUTF8StringEncoding)
                            let tee:String = string as! String
                            response.appendBodyString(tee)
                        }
                        catch {
                            response.setStatus(500, message: "Could not create data")
                        }
                    }
                    results.close()
                }
            }
            mysql.close()
        }
        response.requestCompletedCallback()
    }
	
}


/// student
class StudentHandler: RequestHandler {
    func handleRequest(request: WebRequest, response: WebResponse) {
        response.addHeader("Content-Type", value: "application/json")
        response.addHeader("Content-Type", value: "text/html; charset=utf-8")
        
        let mysql = MySQL()
        let connect = mysql.connect(HOST,user: USER,password: PASSWORD)
        if (connect) {
            let sres = mysql.selectDatabase(SCHEME)
            if (sres) {
                let sres2 = mysql.query("SELECT s_name,s_id FROM student")
                if (sres2) {
                    let results = mysql.storeResults()!
                    if (results.numRows() == 0) {
                        do {
                            let encode = JSONEncoder()
                            let data = try encode.encode(["result":"","success":false,"returnMessae":"could not create data"])
                            response.appendBodyString(data)
                        }
                            
                        catch {
                            response.setStatus(500, message: "Could not create data")
                        }
                    } else {
                        var dataArray:Array<AnyObject> = []
                        var dict = Dictionary<String,String>()
                        while let row = results.next() {
                            dict["s_name"] = row[0];
                            dict["s_id"] = row[1];
                            dataArray.append(dict)
                        }
                        print(NSJSONSerialization.isValidJSONObject(dataArray))
                        
                        do {
                            var dict = Dictionary<String,AnyObject>()
                            dict["result"] = dataArray
                            dict["success"] = true
                            dict["returnMessage"]=""
                            let dataFinal = try NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions(rawValue: 0))
                            let string = NSString(data: dataFinal, encoding: NSUTF8StringEncoding)
                            let tee:String = string as! String
                            response.appendBodyString(tee)
                        }
                        catch {
                            response.setStatus(500, message: "Could not create data")
                        }
                    }
                    results.close()
                }
            }
            mysql.close()
        }
        response.requestCompletedCallback()
    }
    
}

/// class
class ClassHandler: RequestHandler {
    func handleRequest(request: WebRequest, response: WebResponse) {
        response.addHeader("Content-Type", value: "application/json")
        response.addHeader("Content-Type", value: "text/html; charset=utf-8")
        
        let mysql = MySQL()
        let connect = mysql.connect(HOST,user: USER,password: PASSWORD)
        if (connect) {
            let sres = mysql.selectDatabase(SCHEME)
            if (sres) {
                let sres2 = mysql.query("SELECT c_name,c_id FROM class")
                if (sres2) {
                    let results = mysql.storeResults()!
                    if (results.numRows() == 0) {
                        do {
                            let encode = JSONEncoder()
                            let data = try encode.encode(["result":"","success":false,"returnMessae":"could not create data"])
                            response.appendBodyString(data)
                        }
                            
                        catch {
                            response.setStatus(500, message: "Could not create data")
                        }
                    } else {
                        var dataArray:Array<AnyObject> = []
                        var dict = Dictionary<String,String>()
                        while let row = results.next() {
                            dict["s_name"] = row[0];
                            dict["s_id"] = row[1];
                            dataArray.append(dict)
                        }
                        print(NSJSONSerialization.isValidJSONObject(dataArray))
                        
                        do {
                            var dict = Dictionary<String,AnyObject>()
                            dict["result"] = dataArray
                            dict["success"] = true
                            dict["returnMessage"]=""
                            let dataFinal = try NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions(rawValue: 0))
                            let string = NSString(data: dataFinal, encoding: NSUTF8StringEncoding)
                            let tee:String = string as! String
                            response.appendBodyString(tee)
                        }
                        catch {
                            response.setStatus(500, message: "Could not create data")
                        }
                    }
                    results.close()
                }
            }
            mysql.close()
        }
        response.requestCompletedCallback()
    }
    
}


/// grade
class GradeHandler: RequestHandler {
    func handleRequest(request: WebRequest, response: WebResponse) {
        response.addHeader("Content-Type", value: "application/json")
        response.addHeader("Content-Type", value: "text/html; charset=utf-8")
        
        print(request.param("c_id"))
        var select=String("SELECT c_id,s_id,grade FROM grade");
        if (request.params("c_id") != nil && request.params("s_id") != nil) {
            select = select.stringByAppendingString(" WHERE s_id=\(request.param("s_id")!) and c_id=\(request.param("c_id")!)")
        }
        if (request.params("s_id") != nil && request.params("c_id") == nil) {
            select = select.stringByAppendingString(" WHERE s_id=\(request.params("s_id")!)")
        }
        if (request.params("s_id") == nil && request.params("c_id") != nil) {
            select = select.stringByAppendingString(" WHERE c_id=\(request.params("c_id")!)")
        }
        let mysql = MySQL()
        let connect = mysql.connect(HOST,user: USER,password: PASSWORD)
        if (connect) {
            let sres = mysql.selectDatabase(SCHEME)
            if (sres) {
                let sres2 = mysql.query(select)
                if (sres2) {
                    let results = mysql.storeResults()!
                    if (results.numRows() == 0) {
                        do {
                            let encode = JSONEncoder()
                            let data = try encode.encode(["result":"","success":false,"returnMessae":"could not create data"])
                            response.appendBodyString(data)
                        }
                            
                        catch {
                            response.setStatus(500, message: "Could not create data")
                        }
                    } else {
                        var dataArray:Array<AnyObject> = []
                        var dict = Dictionary<String,String>()
                        while let row = results.next() {
                            dict["grade"]=row[2];
                            dict["s_id"] = row[1];
                            dict["c_id"] = row[0];
                            mysql.query("SELECT s_name FROM student WHERE s_id=\(row[1])")
                            let student_result = mysql.storeResults()!
                            let student_row = student_result.next()
                            dict["s_name"]=student_row![0]
                            
                            mysql.query("SELECT c_name FROM class WHERE c_id=\(row[0])")
                            let class_result = mysql.storeResults()!
                            let class_row = class_result.next()
                            dict["c_name"]=class_row![0]

                            dataArray.append(dict)
                        }
                        print(NSJSONSerialization.isValidJSONObject(dataArray))
                        
                        do {
                            var dict = Dictionary<String,AnyObject>()
                            dict["result"] = dataArray
                            dict["success"] = true
                            dict["returnMessage"]=""
                            let dataFinal = try NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions(rawValue: 0))
                            let string = NSString(data: dataFinal, encoding: NSUTF8StringEncoding)
                            let tee:String = string as! String
                            response.appendBodyString(tee)
                        }
                        catch {
                            response.setStatus(500, message: "Could not create data")
                        }
                    }
                    results.close()
                }
            }
            mysql.close()
        }
        response.requestCompletedCallback()
    }
    
}

class RonnieHandler: RequestHandler {
    func handleRequest(request: WebRequest, response: WebResponse) {
        response.addHeader("Content-Type", value: "application/json")
        response.addHeader("Content-Type", value: "text/html; charset=utf-8")
        
        let mysql = MySQL()
        let connect = mysql.connect(HOST,user: USER,password: PASSWORD)
        if (connect) {
            let sres = mysql.selectDatabase(SCHEME)
            if (sres) {
                let sres2 = mysql.query("SELECT name,sex FROM Student")
                if (sres2) {
                    let results = mysql.storeResults()!
                    if (results.numRows() == 0) {
                        do {
                            let encode = JSONEncoder()
                            let data = try encode.encode(["result":""])
                            response.appendBodyString(data)
                        }
                            
                        catch {
                            response.setStatus(500, message: "Could not create data")
                        }
                    } else {
                        var dataArray:Array<AnyObject> = []
                        var dict = Dictionary<String,String>()
                        while let row = results.next() {
                            dict["name"] = row[0];
                            dict["sex"] = row[1];
                            dataArray.append(dict)
                        }
                        print(NSJSONSerialization.isValidJSONObject(dataArray))
                        
                        do {
                            var dict = Dictionary<String,AnyObject>()
                            dict["success"] = true;
                            dict["result"] = dataArray;
                            
                            let dataFinal = try NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions(rawValue: 0))
                            let string = NSString(data: dataFinal, encoding: NSUTF8StringEncoding)
                            let tee:String = string as! String
                            response.appendBodyString(tee)
                        }
                        catch {
                            response.setStatus(500, message: "Could not create data")
                        }
                    }
                    results.close()
                }
            }
            mysql.close()
        }
        response.requestCompletedCallback()
    }
    
}

class Echo2Handler: RequestHandler {
    
    func handleRequest(request: WebRequest, response: WebResponse) {
        response.appendBodyString("<html><body>Echo 2 handler: You GET accessed path \(request.requestURI()) with variables  \(request.urlVariables)<br>")
        response.appendBodyString("<form method=\"POST\" action=\"/user/\(request.urlVariables["id"] ?? "error")/baz\"><button type=\"submit\">POST</button></form></body></html>")
        response.requestCompletedCallback()
    }
}


class Echo3Handler: RequestHandler {
    
    func handleRequest(request: WebRequest, response: WebResponse) {
        var dict = Dictionary<String,String>()
        dict["name"] = "hello";
        
        do {
            var dict = Dictionary<String,AnyObject>()
            dict["success"] = true;
            dict["result"] = "hello";
            
            
            let dataFinal = try NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions(rawValue: 0))
            let string = NSString(data: dataFinal, encoding: NSUTF8StringEncoding)
            let tee:String = string as! String
            response.appendBodyString(tee)
        }
        catch {
            response.setStatus(500, message: "Could not create data")
        }

        response.requestCompletedCallback()
    }
}


