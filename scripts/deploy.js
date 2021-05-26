async function main() {
	const Demo = await ethers.getContractFactory("Demo");
	const demo = await Demo.deploy();   
	console.log("Demo contract deployed to address: ", demo.address);
	
	const Incrementor = await ethers.getContractFactory("Incrementor");
	const incrementor = await Incrementor.deploy();   
	console.log("Incrementor contract deployed to address: ", incrementor.address);
}

main()
	.then(() => process.exit(0))
	.catch(error => {
		console.error(error);
		process.exit(1);
	});