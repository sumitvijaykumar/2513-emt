from datetime import datetime
def convert_to_24_hour( time_12):

 return datetime.strptime(time_12, "%I:%M %p").strftime("%H:%M")

def convertstringtotime(time_string, time_format="%H:%M"):
   

        
        time_object = datetime.strptime(time_string, time_format).time()
        return time_object