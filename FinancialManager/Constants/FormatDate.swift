
import Foundation

func formatDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    
    let dateFomatter = formatter.string(from: date)
    
    return dateFomatter
}
