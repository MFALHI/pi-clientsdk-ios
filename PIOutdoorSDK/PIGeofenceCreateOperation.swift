/**
 *  PIOutdoorSDK
 *  PIGeofenceCreateOperation.swift
 *
 *  Performs all communication to the PI Rest API.
 *
 *  © Copyright 2016 IBM Corp.
 *
 *  Licensed under the Presence Insights Client iOS Framework License (the "License");
 *  you may not use this file except in compliance with the License. You may find
 *  a copy of the license in the license.txt file in this package.
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 **/

import Foundation
import CocoaLumberjack
import CoreLocation

final class PIGeofenceCreateOperation:ServiceOperation {
    
    let fenceName:String
    
    let fenceDescription:String?
    
    let fenceRadius:Int
    
    let fenceCoordinate:CLLocationCoordinate2D
    
    
    init(service: PIService,fenceName:String,fenceDescription:String?,fenceRadius:Int,fenceCoordinate:CLLocationCoordinate2D) {
        self.fenceName = fenceName
        self.fenceDescription = fenceDescription
        self.fenceRadius = fenceRadius
        self.fenceCoordinate = fenceCoordinate
        super.init(service: service)
        self.name = "com.ibm.PI.GeofenceCreateOperation"
    }
    
    override func main() {
        let path = "pi-config/v2/tenants/\(service.tenant)/orgs/\(service.orgCode!)/geofences"
        
        var json:[String:AnyObject] = [:]
        json["type"] = "Feature"
        
        var geometry:[String:AnyObject] = [:]
        geometry["type"] = "Point"
        geometry["coordinates"] = [fenceCoordinate.latitude,fenceCoordinate.longitude]
        json["geometry"] = geometry
        
        var properties:[String:AnyObject] = [:]
        properties["name"] = fenceName
        properties["description"] = fenceDescription
        properties["radius"] = fenceRadius
        json["properties"] = properties
        
        
        let url = NSURL(string:path,relativeToURL:self.service.baseURL)
        let URLComponents = NSURLComponents(URL:url!,resolvingAgainstBaseURL:true)!
        
        DDLogVerbose("\(URLComponents.URL)")
        
        let request = NSMutableURLRequest(URL:URLComponents.URL!,cachePolicy:.ReloadIgnoringLocalCacheData,timeoutInterval:service.timeout)
        
        setBasicAuthHeader(request)
        
        request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(json, options: [])
        request.HTTPMethod = "POST"
        
        performRequest(request) {
            self.executing = false
            self.finished = true
        }
        
        
    }
}