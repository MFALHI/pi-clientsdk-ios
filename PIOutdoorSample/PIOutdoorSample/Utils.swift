/**
 *  PIOutdoorSample
 *  Utils.swift
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



import UIKit


func StringFromClass(obj: AnyClass) -> String {
    return obj.description().componentsSeparatedByString(".").last!
}


func maximum<T:RawRepresentable where T.RawValue:SignedIntegerType > (enumType:T.Type) -> T.RawValue {
    var max: T.RawValue = 0
    while let _ = enumType.init(rawValue: max) {max = max + 1 }
    return max
    
}


class Utils {
    
    static func updateTextStyle(label:UILabel) {
        
        
        let textStyle = label.font.fontDescriptor().fontAttributes()[UIFontDescriptorTextStyleAttribute] as! String
        
        let newFont = UIFont.preferredFontForTextStyle(textStyle)
        
        if label.font != newFont {
            label.font = newFont
        }
        
    }
	
	static func updateBodyTextStyle(label:UILabel) {

		var font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
		if font.pointSize > 22 {
			font = font.fontWithSize(22)
		}
		if font.pointSize < 15 {
			font = font.fontWithSize(15)
		}

		label.font = font

	}
}
