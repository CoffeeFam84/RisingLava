const fs = require('fs');

const image_base_url = 'https://ipfs.io/ipfs/QmZcrDvD8xmfgNdJ2HyJYT3nzqCtLEJmMs2SHT8YcLnB89/images/';
const category = [
	{
		imgName: 'common.jpeg',
		count: 1750,
		name: 'Common'
	}, {
		imgName: 'rare.jpeg',
		count: 500,
		name: 'Rare'
	}, {
		imgName: 'legendary.jpeg',
		count: 250,
		name: 'Legendary'
	}
]
const cnts = [1750, 500, 250];
const image_name = ['common.jpeg', 'rare.jpeg', 'legendary.jpeg'];

function generateMeatadata() {
	let id = 1;
	category.forEach(lava => {
		for (let i = 0; i < lava.count; i++ ) {
			const metadata = {
				name: `${lava.name} Lava #${i+1}`,
				image: image_base_url+lava.imgName,
				description: `${lava.name} Rising Lava`,
				attributes: [
					{
						trait_type: 'Rarity',
						value: lava.name
					}
				]
			};
			fs.writeFileSync(__dirname + `/metadata/${id}.json`, JSON.stringify(metadata), 'utf-8');
			id++;
		}
	});
}

generateMeatadata();