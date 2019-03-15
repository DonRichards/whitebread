# USAGE
# python search.py --dataset images --shelve db.shelve --query images/84eba74d-38ae-4bf6-b8bd-79ffa1dad23a.jpg

# import the necessary packages
from PIL import Image
import imagehash
import argparse
import shelve

# construct the argument parse and parse the arguments
ap = argparse.ArgumentParser()
ap.add_argument("-d", "--dataset", required = True,
	help = "path to dataset of images")
ap.add_argument("-s", "--shelve", required = True,
	help = "output shelve database")
ap.add_argument("-q", "--query", required = True,
	help = "path to the query image")
args = vars(ap.parse_args())

# open the shelve database
db = shelve.open(args["shelve"])

# load the query image, compute the difference image hash, and
# and grab the images from the database that have the same hash
# value
query = Image.open(args["query"])
h = str(imagehash.dhash(query))
filenames = db[h]

count = 0
return_string_message = 'nothing'

# loop over the images
if (len(filenames)) > 1:
	for filename in filenames:
		image = Image.open(args["dataset"] + "/" + filename)
		# image.show()
		with open('fingerprint_analysis_tmp/duplicates_found_by_finger_printing.log', 'r') as f:
			x = f.readlines()
			matching = [s for s in x if str(filename) in s]
			filename_correction = filename.replace("_", ":")
			filename_correction = filename_correction.replace(".jpg", "")
			if (len(matching)) == 0:
				if count == 0:
					return_string_message = "\nFound %d identical images for the following PIDs." % (len(filenames))
				return_string_message += ("\n%s" % filename_correction)
				count += 1
			else:
				count += 1
				return_string_message = "nothing"
else:
	return_string_message = "nothing"
print(return_string_message)
# close the shelve database.
db.close()
