/**
* Copyright (C) 2015 GraphKit, Inc. <http://graphkit.io> and other GraphKit contributors.
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU Affero General Public License as published
* by the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU Affero General Public License for more details.
*
* You should have received a copy of the GNU Affero General Public License
* along with this program located at the root of the software package
* in a file called LICENSE.  If not, see <http://www.gnu.org/licenses/>.
*
* GKActionGroup
*
* Stores a reference to the GKManagedAction Model Object.
*/

import CoreData

@objc(GKActionGroup)
internal class GKActionGroup: NSManagedObject {
	@NSManaged internal var name: String
	@NSManaged internal var node: GKManagedAction
	
	private var context: NSManagedObjectContext?
	internal var worker: NSManagedObjectContext? {
		get {
			if nil == context {
				let graph: GKGraph = GKGraph()
				context = graph.worker
			}
			return context
		}
	}
	
	/**
	* init
	* Initializer for the Model Object.
	* @param        name: String!
	*/
	convenience init(name: String!) {
		let g: GKGraph = GKGraph()
		var w: NSManagedObjectContext? = g.worker
		self.init(entity: NSEntityDescription.entityForName(GKGraphUtility.actionGroupDescriptionName, inManagedObjectContext: w!)!, insertIntoManagedObjectContext: w)
		self.name = name
		context = w
	}
	
	/**
	* delete
	* Deletes the Object Model.
	*/
	internal func delete() {
		worker?.deleteObject(self)
	}
}