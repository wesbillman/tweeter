package com.salesbuilder.util
{
	import mx.collections.ArrayCollection;
	import flash.filesystem.FileStream;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import com.salesbuilder.dao.AccountDAO;
	import com.salesbuilder.dao.ContactDAO;
	import com.salesbuilder.dao.OpportunityDAO;
	import com.salesbuilder.model.Account;
	import com.salesbuilder.model.Contact;
	import com.salesbuilder.model.Opportunity;
	import com.salesbuilder.view.SyncDialog;
	
	public class FileUtility
	{
		private var accounts:ArrayCollection;
		private var contacts:ArrayCollection;
		private var opportunities:ArrayCollection;
		private var accountContacts:Object;
		private var accountOpportunities:Object;
		
		private var syncDialog:SyncDialog;
		private var count:int = 0;

		public function databaseToXML():void
		{
			var accountDAO:AccountDAO = new AccountDAO();
			accounts = accountDAO.findAll();
			var contactDAO:ContactDAO = new ContactDAO();
			contacts = contactDAO.findAll();
			var opportunityDAO:OpportunityDAO = new OpportunityDAO();
			opportunities = opportunityDAO.findAll();

			accountContacts = new Object();
			accountOpportunities = new Object();

			var xml:String;

			for (var i:int=0; i<contacts.length; i++)
			{
				var contact:Contact = contacts.getItemAt(i) as Contact;
				xml =
					"\t\t<contact>\n" +
					"\t\t\t<contactId>" + contact.contactId + "</contactId>\n" +
					"\t\t\t<firstName>" + contact.firstName + "</firstName>\n" +
					"\t\t\t<lastName>" + contact.lastName + "</lastName>\n" +
					"\t\t\t<title>" + contact.title + "</title>\n" +
					"\t\t\t<managerId>" + contact.manager.contactId + "</managerId>\n" +
					"\t\t\t<owner>" + contact.owner + "</owner>\n" +
					"\t\t\t<officePhone>" + contact.officePhone + "</officePhone>\n" +
					"\t\t\t<cellPhone>" + contact.officePhone + "</cellPhone>\n" +
					"\t\t\t<fax>" + contact.fax + "</fax>\n" +
					"\t\t\t<email>" + contact.email + "</email>\n" +
					"\t\t\t<priority>" + contact.priority + "</priority>\n" +
					"\t\t\t<address1>" + contact.address1 + "</address1>\n" +
					"\t\t\t<address2>" + contact.address2 + "</address2>\n" +
					"\t\t\t<city>" + contact.city + "</city>\n" +
					"\t\t\t<state>" + contact.state + "</state>\n" +
					"\t\t\t<zip>" + contact.zip + "</zip>\n" +
					"\t\t\t<notes>" + contact.notes + "</notes>\n" +
					"\t\t\t<lastUpdated>" + contact.lastUpdated + "</lastUpdated>\n" +
					"\t\t</contact>\n";
					
				if (accountContacts[contact.account.accountId])
					accountContacts[contact.account.accountId] += xml;
				else
					accountContacts[contact.account.accountId] = xml;
			}

			for (var j:int=0; j<opportunities.length; j++)
			{
				var opportunity:Opportunity = opportunities.getItemAt(j) as Opportunity;
				xml =
					"\t\t<opportunity>\n" +
					"\t\t\t<opportunityId>" + opportunity.opportunityId + "</opportunityId>\n" +
					"\t\t\t<name>" + opportunity.name + "</name>\n" +
					"\t\t\t<expectedAmount>" + opportunity.expectedAmount + "</expectedAmount>\n" +
					"\t\t\t<expectedCloseDate>" + opportunity.expectedCloseDate.time + "</expectedCloseDate>\n" +
					"\t\t\t<probability>" + opportunity.probability + "</probability>\n" +
					"\t\t\t<owner>" + opportunity.owner + "</owner>\n" +
					"\t\t\t<status>" + opportunity.status + "</status>\n" +
					"\t\t\t<lastUpdated>" + opportunity.lastUpdated + "</lastUpdated>\n" +
					"\t\t</opportunity>\n";
					
				if (accountOpportunities[opportunity.account.accountId])
					accountOpportunities[opportunity.account.accountId] += xml;
				else
					accountOpportunities[opportunity.account.accountId] = xml;
			}

			xml = "<data>\n";

			for (var k:int=0; k<accounts.length; k++)
			{
				var account:Account = accounts.getItemAt(k) as Account;
				xml+=
					"\t<account>\n" +
					"\t\t<accountId>" + account.accountId + "</accountId>\n" +
					"\t\t<name>" + account.name + "</name>\n" +
					"\t\t<type>" + account.type + "</type>\n" +
					"\t\t<industry>" + account.industry + "</industry>\n" +
					"\t\t<owner>" + account.owner + "</owner>\n" +
					"\t\t<phone>" + account.phone + "</phone>\n" +
					"\t\t<fax>" + account.fax + "</fax>\n" +
					"\t\t<ticker>" + account.ticker + "</ticker>\n" +
					"\t\t<ownership>" + account.ownership + "</ownership>\n" +
					"\t\t<numberEmployees>" + account.numberEmployees + "</numberEmployees>\n" +
					"\t\t<annualRevenue>" + account.annualRevenue + "</annualRevenue>\n" +
					"\t\t<priority>" + account.priority + "</priority>\n" +
					"\t\t<rating>" + account.rating + "</rating>\n" +
					"\t\t<address1>" + account.address1 + "</address1>\n" +
					"\t\t<address2>" + account.address2 + "</address2>\n" +
					"\t\t<city>" + account.city + "</city>\n" +
					"\t\t<state>" + account.state + "</state>\n" +
					"\t\t<zip>" + account.zip + "</zip>\n" +
					"\t\t<currentYearResults>" + account.currentYearResults + "</currentYearResults>\n" +
					"\t\t<lastYearResults>" + account.lastYearResults + "</lastYearResults>\n" +
					"\t\t<notes>" + account.notes + "</notes>\n" +
					"\t\t<lastUpdated>" + account.lastUpdated + "</lastUpdated>\n";
					if (accountContacts[account.accountId])
						xml += accountContacts[account.accountId];
					if (accountOpportunities[account.accountId])
						xml += accountOpportunities[account.accountId];
					xml += "\t</account>\n";
			}

			xml += "</data>\n";
			
			var file:File = File.documentsDirectory.resolvePath("salesbuilderdata.xml");
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.WRITE);
			fileStream.writeUTFBytes(xml);
			fileStream.close();
			
		}

		
	}
}