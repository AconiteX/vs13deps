using System;
using System.Collections.Generic;
$if$ ($targetframeworkversion$ >= 3.5)using System.Linq;
$endif$using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;

namespace $safeprojectname$
{
	// NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "IService1" in both code and config file together.
	[ServiceContract]
	public interface IService1
	{
		[OperationContract]
		string GetData(int value);

		[OperationContract]
		CompositeType GetDataUsingDataContract(CompositeType composite);

		// TODO: Add your service operations here
	}

	// Use a data contract as illustrated in the sample below to add composite types to service operations.
	$if$ ($targetframeworkversion$ >= 4.5)// You can add XSD files into the project. After building the project, you can directly use the data types defined there, with the namespace "$safeprojectname$.ContractType".
	$endif$[DataContract]
	public class CompositeType
	{
		bool boolValue = true;
		string stringValue = "Hello ";

		[DataMember]
		public bool BoolValue
		{
			get { return boolValue;}
			set { boolValue = value;}
		}

		[DataMember]
		public string StringValue
		{
			get { return stringValue;}
			set { stringValue = value;}
		}
	}
}
