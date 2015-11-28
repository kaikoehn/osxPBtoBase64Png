//: Playground - noun: a place where people can play

import Cocoa

extension NSImage {
    var imagePNGRepresentation: NSData {
        return NSBitmapImageRep(data: TIFFRepresentation!)!.representationUsingType(.NSPNGFileType, properties: [:])!
    }
    func savePNG(path:String) -> Bool {
        return imagePNGRepresentation.writeToFile(path, atomically: true)
    }
}

let pb = NSPasteboard.generalPasteboard()
let typeArr:[AnyClass] = [NSImage.self]

let tmp = pb.readObjectsForClasses(typeArr, options: nil)
if tmp?.count > 0 {
    let img = tmp![0] as! NSImage
    
    let good_b64 = img.imagePNGRepresentation.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
    let finalResult = "data:image/png;base64," + good_b64;
    pb.clearContents()
    pb.writeObjects([finalResult])
}
