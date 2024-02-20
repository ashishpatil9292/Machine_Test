//
//  ImageFilter.swift
//  Machin_Test_ProsperInfotech
//
//  Created by ashish patil on 20/02/24.
//

import CoreImage
import UIKit

enum ImageFilterType : String, CustomStringConvertible ,CaseIterable
{
    case none = "None"
    case sepia = "Sepia"
    case motionBlur = "Motion Blur"
    case colorInvert = "Color Invert"
    case crystallize = "Crystallize"
    case comic = "Comic Effect"
    
    var description: String {
        return self.rawValue
    }
}

class Filter
{
    static let context = CIContext()
    
    static func getFilteredImage(selectedFilter:ImageFilterType,ciImage:CIImage) -> UIImage?
    {
        switch selectedFilter
        {
        case .none:
            return nil
        case .sepia:
            return  applySepia(ciImage: ciImage)
        case .motionBlur:
            return  applyMotionBlur(ciImage: ciImage)
        case .colorInvert:
            return  applyColorInvert(ciImage: ciImage)
        case .crystallize:
            return  applyCrystallize(ciImage: ciImage)
        case .comic:
            return  applyComicEffect(ciImage: ciImage)
            
        }
    }
    
    static func applySepia(ciImage:CIImage?) -> UIImage?  {
        guard let ciImage else { return nil }
        let filter = CIFilter(name: "CISepiaTone")
        filter?.setValue(ciImage, forKey: "inputImage")
        filter?.setValue(0.9, forKey: "inputIntensity")
        return getImage(usingFilter: filter)
    }
    
    static func applyMotionBlur(ciImage:CIImage?) -> UIImage?  {
        guard let ciImage else { return nil }
        let filter = CIFilter(name: "CIMotionBlur")
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        filter?.setValue(30.0, forKey: kCIInputRadiusKey)
        filter?.setValue(20.0, forKey: kCIInputAngleKey)
        return getImage(usingFilter: filter)
    }
    
    static func applyColorInvert(ciImage:CIImage?) -> UIImage?  {
        guard let ciImage else { return nil }
        let filter = CIFilter(name: "CIColorInvert")
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        return getImage(usingFilter: filter)
    }
    
    static  func applyCrystallize(ciImage:CIImage?) -> UIImage?  {
        guard let ciImage else { return nil }
        let filter = CIFilter(name: "CICrystallize")
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        filter?.setValue(35, forKey: kCIInputRadiusKey)
        filter?.setValue(CIVector(x: 200, y: 200), forKey: kCIInputCenterKey)
        return getImage(usingFilter: filter)
    }
    
    static  func applyComicEffect(ciImage:CIImage?) -> UIImage?  {
        guard let ciImage else { return nil }
        let filter = CIFilter(name: "CIComicEffect")
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        return getImage(usingFilter: filter)
    }
    
    static func getImage(usingFilter filter: CIFilter?) -> UIImage? {
        guard let output = filter?.outputImage else { return nil}
        guard let cgImage = context.createCGImage(output, from: output.extent) else { return nil}
        return UIImage(cgImage: cgImage)
    }
}
