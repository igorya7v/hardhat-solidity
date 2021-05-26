const { expect } = require("chai");
const { BigNumber } = require("ethers");

describe("Demo", function() {
	
	weth = ethers.utils.getAddress("0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2");
	dai = ethers.utils.getAddress("0x6B175474E89094C44Da98b954EedeAC495271d0F");
	daiAsBigNumber = BigNumber.from("611382286831621467233887798921843936019654057231");
	uniswapEthDaiPairAddress = ethers.utils.getAddress("0xa478c2975ab1ea89e8196811f51a7b7ade33eb11");
	
	beforeEach(async function () {
		[admin] = await ethers.getSigners();
		adminAddress = await admin.getAddress();
		Demo = await ethers.getContractFactory("Demo");
		demo = await Demo.deploy();
		Incrementor = await ethers.getContractFactory("Incrementor");
		incrementor = await Incrementor.deploy();
	});
  
	it("Delegates incrementing of storage variables", async function () {
		await demo.incrementX(incrementor.address);
		expect(await demo.x()).to.equal(BigNumber.from(1));
		
		await demo.incrementY(incrementor.address);
		expect(await demo.y()).to.equal(BigNumber.from(1));
    });
	
	it("Determines if an Ethereum account is a contract", async function () {
		expect(await demo.isContract(demo.address)).to.be.true;
		expect(await demo.isContract(adminAddress)).to.be.false;
    });
	
	it("Converts address to uint256", async function () {
		expect(await demo.addressToUint256(dai)).to.equal(daiAsBigNumber);
    });
	
	it("Converts uint256 to address", async function () {
		expect(await demo.uint256ToAddress(daiAsBigNumber)).to.equal(dai);
    });
	
	it("Computes UniswapV2 pair addresses", async function () {
		computedPair = await demo.getUniswapV2PairAddress(weth, dai);
		expect(computedPair).to.equal(uniswapEthDaiPairAddress);
    });
});